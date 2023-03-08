# 1 - Loading up UserDefaults

It's not uncommon for me to have various discussions over coffee with a good friend of mine Matt.  This usually happens Monday morning after a routine Brazilian Jiu Jitsu session at 6:30 am.  Since it is the advanced class, the shower is a bit more of a struggle than any other day of the week.  However, there is something about joint pain caused by young seedlings that often creates an explosion of topics to discuss.  So many in fact, that sometimes I have to jot them down on the notes app so that I don’t forget them.  Don’t be mistaken of course.  Many of the topics aren’t particularly deep or intelligent, and many times consist of speaking at length regarding dog mental health, metaphorically yelling about others to get off our lawn or just expressing our undying love for the finer things in life (`Objective-C`). Eventually though, we always delve into tech topics.

As we were discussing our challenges with `CoreData` in one of these sessions, it dawned on me that I never truly hit any performance roadblocks using `UserDefaults` on any of the 25+ iOS projects I've worked on.  Looking back on some of the technological persistent store decisions that either I inherited and/or chose, I reflected on whether or not complex solutions were even needed.  After spending 10-15 minutes in deep discussion describing our past experience, we both realized that neither of us truly understood the limits of `UserDefaults`.  Could it have been used in past experience that could have been both, easier to implement and cost effective from a project standpoint?  Or did we ultimately succumb to the "over optimization demons" that are always constantly nudging us towards project destruction?

Who knows?

Well... maybe it's time to figure this out.

## Getting started

While a serious examination can be done to be completely precise about numbers, this exercise is more about “[napkin math](https://en.wiktionary.org/wiki/napkin_math).”  This means that I will attempt to provide numbers that are more of an estimation rather than actual hard results.

Since I’m focusing on napkin math, I’m just using the simulator for my calculations.  This is with the understanding that the results themselves could be significantly different from a real device.  Maybe in the future these can be repeated on a physical device and log the differences in speed performance.

I’m also going to lean on the `XCTest` framework, in particularly the `measure` method.  This method runs “work” various times and averages the results and presents them inside the Xcode IDE.

## What I discovered

I discovered what I assumed based on my experience. `UserDefaults` is tough.  It can be beat to death with thousands of entries at a time.  It handles integers especially well.  I was able to add 1 million integers in less than `5` seconds.

As expected, it looks like it starts to slow down on `Arrays`, `Dictionaries` and custom objects. However, I was still able to save data in the thousands for each of these types quickly enough between `1-3` seconds.  I would like to mention though that I wasn’t able to fully stress test `UserDefaults` due to project “hanging” issues.

Oh and did you know you can’t save dictionaries to `UserDefaults` with an integer key? That was news to me.

## Problems… sigh

### XCTest Measurements

Well I understood that the `XCTest` framework has a `measure` method.  I figured I’d use that.  However, I noticed that throughout this exercise Xcode would not bubble up the time measurement results.  It require things such as, restarting Xcode, restarting the simulator and project cleans before results would be shown on the IDE.  Like most Apple testing tools, you must use at your own risk.  I’ve noticed similar things when using the UITests platform in the past.  I always recommend that these tools should be used for R & D purposes only, and not for project build “gatekeeping” or hooked up to CI/CD boxes as they regularly make the containers fall over or timeout.

### Hanging: Xcode, XCTest, Simulator or UserDefaults?

In addition to XCTest measurements being finicky showing results, I had lots of issues with the tests hanging.  If you’ve noticed already in the tests themselves, the number of items being added to `UserDefaults` is pretty arbitrary.  You’ll see 1 million being added for integers, while only a thousand dictionaries are being added.  Once larger data sets were being added to UserDefaults, the project would hang.  I’m not talking about extremely large data sets either.  It was incredibly unpredictable and not based on processing time at all.  For example, if it took `0.9` seconds to add `1000` custom objects to `UserDefaults`, if I just attempted 1500, the entire project would hang.  This would also require full restarts of Xcode, the simulator and/or the tests would start running properly.  Based on the short time I spent playing around with the numbers, I was unable to truly determine what the issue is.

### UserDefaults

Finally, one issue I’ve noticed during the experimentation is issues with files on the disk.  At first I was “reseting” user defaults using the api, but noticed it was slow.  To resolve this, I would actually delete the file from disk.  Unfortunately creating/deleting the actual `plist` file over and over again very quickly caused unexpected results.  This really isn’t an issue, as nobody would ever do this in a production app.  It could be an issue if your project only has integration tests with setup/teardown methods that attempt to reset the state of `UserDefaults`, but as I always say, use unit tests to lean on `UserDefaults` functionality =)

## Final Thoughts

Let’s start with `XCTest.measure`.  If I want to take some measurements seriously, I think I might want to build my own measurement tool.  Not only did it have issues with stability, there was also no way to reset state between each measurement (it runs at least two).  This became a problem when I needed to reset `UserDefaults` after each measurement to keep the datastore empty.  There is also no way to run a single measurement.  While I understand that it’s better to run multiple measurements and average, sometimes you only want to use one.

In regards to `UserDefaults`, let’s give credit where credit is due.  It is dirt simple and I encourage all to use it due to its simplicity and its ability to handle a lot more persistent scenarios that we give it credit for.  Everybody is so quick to start adding a database, object graph model or ORM to their project the minute they need to start storing data.  I understand that some of the motivations are, “it’s fun,” or “we will need it.”  But will you need it?  Most of the time you don’t.  As always, I recommend that you pick the right tool for the job for the intermediate future, with a cautious eye for the long term future.  While scaling is always a concern in the software world, most of the time fear based implementations are an even bigger one.
# 1 - Loading up UserDefaults

It's not uncommon for me to have various discussions over coffee with a good friend of mine Matt.  This usually happens Monday morning after a routine Brazilian Jiu Jitsu session at 6:30 am.  Since it is the advanced class, the shower is a bit more of a struggle than any other day of the week.  However, there is something about joint pain caused by young seedlings that often creates an explosion of topics to discuss.  So many in fact, that sometimes I have to jot them down on the notes app so that I don’t forget them.  Don’t be mistaken of course.  Many of the topics aren’t particularly deep or intelligent, and many times consist of speaking at length regarding dog mental health, metaphorically yelling about others to get off our lawn or just expressing our undying love for the finer things in life (`Objective-C`). Eventually though, we always delve into tech topics.

As we were discussing our challenges with `CoreData` in one of these sessions, it dawned on me that I never truly hit any roadblocks using `UserDefaults` on any of the 25+ iOS projects I've worked on.  Looking back on some of the technological persistent store decisions that either I inherited and/or chose, I reflected on whether or not complex solutions were even needed.  After spending 10-15 minutes in deep discussion describing our past experience, it dawned on us that neither of us truly understood the limits of `UserDefaults`.  Could it have been used in past experience that could have been both, easier to implement and cost effective from a project standpoint?  Or did we ultimately succumb to the "over optimization demons" that are always constantly nudging us towards project destruction?

Who knows?

Well... maybe it's time to figure this out once and for all.

## Getting started

TDB: - Describe how the measurements were going to be taken, and why.
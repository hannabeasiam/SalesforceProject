trigger DedupeReminder on Account (after insert) {
    for (Account acc : Trigger.new) {
        Case c = new Case();
        c.Subject = 'Dedupe this Account';
        c.OwnerId = '0052E00000I19JXQAZ';
        c.AccountId = acc.Id;
        insert c;
    }
}
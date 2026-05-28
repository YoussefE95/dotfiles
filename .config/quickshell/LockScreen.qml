// This stores all the information shared between the lock surfaces on each screen.
LockContext {
    id: lockContext

    onUnlocked: {
        lock.locked = false;
    }
}

WlSessionLock {
    id: lock

    locked: false

    WlSessionLockSurface {
        LockSurface {
            anchors.fill: parent
            context: lockContext
        }
    }
}

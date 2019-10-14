import Foundation

enum AppAction{
    case learner(LearnerAction)
    case question(QuestionAction)
    case activity(ActivityAction)
    case user(UserAction)
    case setup(SetupAction)

    var learner: LearnerAction? {
        get {
            guard case let .learner(value) = self else { return nil }
            return value
        }
        set {
            guard case .learner = self, let newValue = newValue else { return }
            self = .learner(newValue)
        }
    }

    var question: QuestionAction? {
        get {
            guard case let .question(value) = self else { return nil }
            return value
        }
        set {
            guard case .question = self, let newValue = newValue else { return }
            self = .question(newValue)
        }
    }

    var activity: ActivityAction? {
        get {
            guard case let .activity(value) = self else { return nil }
            return value
        }
        set {
            guard case .activity = self, let newValue = newValue else { return }
            self = .activity(newValue)
        }
    }

    var user: UserAction? {
        get {
            guard case let .user(value) = self else { return nil }
            return value
        }
        set {
            guard case .user = self, let newValue = newValue else { return }
            self = .user(newValue)
        }
    }

    var setup: SetupAction? {
        get {
            guard case let .setup(value) = self else { return nil }
            return value
        }
        set {
            guard case .setup = self, let newValue = newValue else { return }
            self = .setup(newValue)
        }
    }
}

enum LearnerAction{
    case create(name: String, imageString: String?, image: Data?)
    case edit(learner: Learner, name: String, image: Data?)

    

    var create: (name: String, imageString: String?, image: Data?)? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(name: newValue.0, imageString: newValue.1, image: newValue.2)
        }
    }

    var edit: (learner: Learner, name: String, image: Data?)? {
        get {
            guard case let .edit(value) = self else { return nil }
            return value
        }
        set {
            guard case .edit = self, let newValue = newValue else { return }
            self = .edit(learner: newValue.0, name: newValue.1, image: newValue.2)
        }
    }
}

enum QuestionAction{
    case create(questionText: String, answerText: String?, asker: Learner)
    case edit(questionText: String, answerText: String?, asker: Learner, question: Question)

    var create: (questionText: String, answerText: String?, asker: Learner)? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(questionText: newValue.0, answerText: newValue.1, asker: newValue.2)
        }
    }

    var edit: (questionText: String, answerText: String?, asker: Learner, question: Question)? {
        get {
            guard case let .edit(value) = self else { return nil }
            return value
        }
        set {
            guard case .edit = self, let newValue = newValue else { return }
            self = .edit(questionText: newValue.0, answerText: newValue.1, asker: newValue.2, question: newValue.3)
        }
    }

}

enum ActivityAction{
    case create(activityDate: Date, title: String, image: Data?, notes: String?, participants: [Learner])
    case edit(activityDate: Date, title: String, image: Data?, notes: String?, tags: [Tag], participants: [Learner], activity: Activity)

    var create: (activityDate: Date, title: String, image: Data?, notes: String?, participants: [Learner])? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(activityDate: newValue.0, title: newValue.1, image: newValue.2, notes: newValue.3, participants: newValue.4)
        }
    }

    var edit: (activityDate: Date, title: String, image: Data?, notes: String?, tags: [Tag], participants: [Learner], activity: Activity)? {
        get {
            guard case let .edit(value) = self else { return nil }
            return value
        }
        set {
            guard case .edit = self, let newValue = newValue else { return }
            self = .edit(activityDate: newValue.0, title: newValue.1, image: newValue.2, notes: newValue.3, tags: newValue.4, participants: newValue.5, activity: newValue.6)
        }
    }

   
}

enum UserAction{
    case create(firstName: String, lastName: String)

    var create: (firstName: String, lastName: String)? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(firstName: newValue.0, lastName: newValue.1)
        }
    }
}

enum SetupAction{
    case finish
}



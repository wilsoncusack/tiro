import Foundation

enum AppAction{
    case learner(LearnerAction)
    case question(QuestionAction)
    case activity(ActivityAction)
    case user(UserAction)
    case setup(SetupAction)
    case tag(TagAction)
    case toDo(ToDoAction)

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

    var tag: TagAction? {
        get {
            guard case let .tag(value) = self else { return nil }
            return value
        }
        set {
            guard case .tag = self, let newValue = newValue else { return }
            self = .tag(newValue)
        }
    }

    var toDo: ToDoAction? {
        get {
            guard case let .toDo(value) = self else { return nil }
            return value
        }
        set {
            guard case .toDo = self, let newValue = newValue else { return }
            self = .toDo(newValue)
        }
    }
}


enum UserAction{
    case create(birthday: Date?, image: Data?, firstName: String, lastName: String)

    var create: (birthday: Date?, image: Data?, firstName: String, lastName: String)? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(birthday: newValue.0, image: newValue.1, firstName: newValue.2, lastName: newValue.3)
        }
    }

   

    
}

enum SetupAction{
    case finish
}

enum TagAction{
    case create(name: String, tagType: TagType)

    var create: (name: String, tagType: TagType)? {
        get {
            guard case let .create(value) = self else { return nil }
            return value
        }
        set {
            guard case .create = self, let newValue = newValue else { return }
            self = .create(name: newValue.0, tagType: newValue.1)
        }
    }
}



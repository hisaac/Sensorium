import Combine

final class LogAction: Action {
	let name = #file
	let friendlyName = "Log Action"
	let description = "Action for logging events"

	var subscriber: any Subscriber

	init() {
		subscriber = LogSubscriber()
	}

	struct LogSubscriber: Subscriber {
		typealias Input = SensedEvent
		typealias Failure = Never

		let combineIdentifier = CombineIdentifier()

		func receive(subscription: Subscription) {

		}

		func receive(_ input: Input) -> Subscribers.Demand {
			return .unlimited
		}

		func receive(completion: Subscribers.Completion<Never>) {

		}
	}
}

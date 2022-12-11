import Combine

final class LogReacter: Reacter {
	let name = #file
	let friendlyName = "Log Reacter"
	let description = "Reacter for logging events"

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

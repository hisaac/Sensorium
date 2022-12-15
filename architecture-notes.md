# Architecture Notes

Some initial notes and ideas on how Sensorium could be architected.

## Types

Pseudo-code outlining some ideas for types within Sensorium.

`SensorManager`

```swift
/// A high-level class for managing and connecting `Sensors` and `Actions`
class SensorManager {
	/// A `Set` of `Sensors` currently being managed
	var managedSensors: Set<Sensor>

	/// A dedicated method for adding a `Sensor` to the `managedSensors`.
	/// This may or may not be useful. I can see it being useful if there needs to be
	/// additional validation or work done before beginning to monitor a `Sensor`.
	func addSensor(Sensor)

	/// A dedicated method for removing a `Sensor` from `managedSensors`.
	/// This would be done when a user no longer needs to sense for a specific event type.
	///
	/// The `ID` would be used to determine which `Sensor` to remove.
	/// I'm not sure yet what type the `ID` would be. It could just be the `Sensor`'s `name`
	/// property, but perhaps there's value to using some sort of `UUID` instead?
	func removeSensor(ID: ??)
}
```

`Sensor`

```swift
/// A `Sensor` monitors the system for specific events or conditions,
/// emitting `SensedEvent`s through its `Publisher` to any subscribed objects
protocol Sensor {
	/// The internal name of the `Sensor`
	/// (this will normally just be the name of the class that implements the protocol)
	var name: String

	/// The user-facing name of the `Sensor`
	var friendlyName: String

	/// A user-facing description of the `Sensor`
	var description: String

	/// The object that publishes events to be used by Actions
	/// Emits a `SensedEvent` for use by an `Action`, or anything of type `Error` on errors
	var publisher: any Publisher<SensedEvent, Error>
}
```

`SensedEvent`

```swift
/// A protocol describing any event being passed from a `Sensor` to any subscribed objects
protocol SensedEvent {
	/// The internal name of the event
	var name: String

	/// An optional dictionary containing key-value pairs of additional data relevent to the event
	var info: Dictionary<AnyHashable: Any>?
}
```

`Action`

```swift
/// A protocol describing attributes of any `Action` that can be performed in reaction to a `Sensor`
/// emitting a `SensedEvent`.
protocol Action {
	/// The internal name of the `Action`
	var name: String

	/// The user-facing name of the `Action`
	var friendlyName: String

	/// The user-facing description of the `Action`
	var description: String

	/// Configuration object for this `Action` instance.
	///
	/// I think some static configuration for an `Action` could be useful, because a `SensedEvent`
	/// may not include all the information required to determine how to perform the action. I'm
	/// not sure yet what the structure would look like.
	var configuration: ActionConfiguration

	/// A method for performing the object's `Action`.
	/// The method takes in a `SensedEvent` emitted by a `Sensor`, which can be used to customize
	/// the `Action` performed.
	func perform(event: SensedEvent)
}
```

`ActionConfiguration`

```swift
/// A protocol describing configuration information for `Action`s
protocol ActionConfiguration {
	// still brainstorming what this would look like
}
```

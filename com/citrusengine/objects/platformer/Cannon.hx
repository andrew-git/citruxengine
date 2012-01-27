/**
package com.citrusengine.objects.platformer;

import com.citrusengine.objects.PhysicsObject;
import org.osflash.signals.Signal;
import flash.events.TimerEvent;
import flash.utils.Timer;

class Cannon extends Platform {

	/**
	@:meta(Property(value="2000"))
	public var fireRate : Float;
	/**
	@:meta(Property(value="right"))
	public var startingDirection : String;
	/**
	@:meta(Property(value="true"))
	public var openFire : Bool;
	@:meta(Property(value="20"))
	public var missileWidth : UInt;
	@:meta(Property(value="20"))
	public var missileHeight : UInt;
	@:meta(Property(value="2"))
	public var missileSpeed : Float;
	@:meta(Property(value="0"))
	public var missileAngle : Float;
	@:meta(Property(value="1000"))
	public var missileExplodeDuration : Float;
	@:meta(Property(value="1000"))
	public var missileFuseDuration : Float;
	@:meta(Property(value="",browse="true"))
	public var missileView : String;
	/**
	public var onGiveDamage : Signal;
	var _firing : Bool;
	var _timer : Timer;
	public function new(name : String, params : Dynamic = null) {
		fireRate = 2000;
		startingDirection = "right";
		openFire = true;
		missileWidth = 20;
		missileHeight = 20;
		missileSpeed = 2;
		missileAngle = 0;
		missileExplodeDuration = 1000;
		missileFuseDuration = 10000;
		missileView = "";
		_firing = false;
		super(name, params);
		onGiveDamage = new Signal(PhysicsObject);
		if(openFire) startFire();
	}

	override public function destroy() : Void {
		onGiveDamage.removeAll();
		_timer.stop();
		_timer.removeEventListener(TimerEvent.TIMER, _fire);
		super.destroy();
	}

	override public function update(timeDelta : Float) : Void {
		super.update(timeDelta);
		_updateAnimation();
	}

	function _damage(missile : Missile, contact : PhysicsObject) : Void {
		if(contact != null)  {
			onGiveDamage.dispatch(contact);
		}
	}

	public function startFire() : Void {
		_firing = true;
		_timer = new Timer(fireRate);
		_timer.addEventListener(TimerEvent.TIMER, _fire);
		_timer.start();
	}

	public function stopFire() : Void {
		_firing = false;
		_timer.stop();
		_timer.removeEventListener(TimerEvent.TIMER, _fire);
	}

	function _fire(tEvt : TimerEvent) : Void {
		var missile : Missile;
		if(startingDirection == "right")  {
			missile = new Missile("Missile", {
				x : x + width
				y : y,
				width : missileWidth,
				height : missileHeight,
				speed : missileSpeed,
				angle : missileAngle,
				explodeDuration : missileExplodeDuration,
				fuseDuration : missileFuseDuration,
				view : missileView,

			});
		}

		else  {
			missile = new Missile("Missile", {
				x : x - width
				y : y,
				width : missileWidth,
				height : missileHeight,
				speed : -missileSpeed,
				angle : missileAngle,
				explodeDuration : missileExplodeDuration,
				fuseDuration : missileFuseDuration,
				view : missileView,

			});
		}

		_ce.state.add(missile);
		missile.onExplode.addOnce(_damage);
	}

	function _updateAnimation() : Void {
		if(_firing)  {
			_animation = "fire";
		}

		else  {
			_animation = "normal";
		}

	}

}

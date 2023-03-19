(define (domain stretch) ;;

(:requirements :strips :typing :fluents :disjunctive-preconditions :durative-actions)

(:types
	waypoint 
	robots
  update
)

(:predicates
	(robots_at ?v - robots ?wp - waypoint)
	(visited ?wp - waypoint)
	(undocked ?v - robots)
	(docked ?v - robots)
	(localised ?v - robots)
	(dock_at ?wp - waypoint)
)

;; Move arm to any waypoint or goal, avoiding obstacles
(:durative-action goto_waypoint
	:parameters (?v - robots ?from ?to - waypoint)
	:duration ( = ?duration 1)
	:condition (and
		(at start (robots_at ?v ?from))
		(at start (localised ?v))
		(over all (undocked ?v)))
	:effect (and
		(at end (visited ?to))
		(at end (robots_at ?v ?to))
		(at start (not (robots_at ?v ?from))))
)

;; Localise
(:durative-action localise
	:parameters (?v - robots)
	:duration ( = ?duration 1)
	:condition (over all (undocked ?v))
	:effect (at end (localised ?v))
)

;; Dock to charge
(:durative-action dock
	:parameters (?v - robots ?wp - waypoint)
	:duration ( = ?duration 3)
	:condition (and
		(over all (dock_at ?wp))
		(at start (robots_at ?v ?wp))
		(at start (undocked ?v)))
	:effect (and
		(at end (docked ?v))
		(at start (not (undocked ?v))))
)

(:durative-action undock
	:parameters (?v - robots ?wp - waypoint)
	:duration ( = ?duration 2)
	:condition (and
		(over all (dock_at ?wp))
		(at start (docked ?v)))
	:effect (and
		(at start (not (docked ?v)))
		(at end (undocked ?v)))
)

) 

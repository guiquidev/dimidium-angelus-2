extends Node

enum ActionType {
	ATTACK,
	SKILL,
	BUFF,
}

enum ActionTarget {
	SELF,
	OTHER,
	BOTH,
}

enum BuffType {
	DAMAGE,
	ARMOR,
	ANY,
	NONE,
}

enum BuffDuration {
	NEXT_ACTION,
	NEXT_ATTACK,
	NEXT_BUFF,
	NEXT_TURN,
	NEXT_HIT,
	COMBAT,
	ANY,
	NONE,
}

enum RoomType {
	COMBAT,
	SHOP,
	BONFIRE,
	EVENT,
	OTHER,
}

enum SoundEffect {
	ATTACK,
	SKILL,
	BUFF,
	NOT_ENOUGH_MANA,
}

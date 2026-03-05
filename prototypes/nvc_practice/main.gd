extends Control

## --- Tuning ---
@export var typing_speed: float = 0.02  ## seconds per character for typewriter effect
## --- End Tuning ---

# ─── Theme Colors ───
const BG_COLOR := Color("#1a1a2e")
const PANEL_COLOR := Color("#16213e")
const PANEL_LIGHT := Color("#1c2a4a")
const HEADER_COLOR := Color("#0f3460")
const ACCENT := Color("#4ecdc4")
const ACCENT_DIM := Color("#3ba89f")
const TEXT_COLOR := Color("#e8e8e8")
const TEXT_DIM := Color("#8899aa")
const TEXT_WARM := Color("#f0d9b5")
const GREEN := Color("#66bb6a")
const AMBER := Color("#ffb74d")
const RED := Color("#ef5350")
const GOLD := Color("#ffd54f")

# ─── NVC Word Banks ───
const FEELING_WORDS := [
	"frustrated", "annoyed", "hurt", "sad", "disappointed", "anxious",
	"overwhelmed", "upset", "worried", "lonely", "confused", "embarrassed",
	"exhausted", "uncomfortable", "uneasy", "concerned", "distressed",
	"happy", "grateful", "relieved", "hopeful", "excited", "calm",
	"comfortable", "pleased", "satisfied", "touched", "glad",
]

const NEED_WORDS := [
	"respect", "understanding", "connection", "cooperation", "consideration",
	"autonomy", "honesty", "trust", "fairness", "support", "appreciation",
	"space", "rest", "safety", "belonging", "acknowledgment", "reliability",
	"predictability", "clarity", "harmony", "peace", "care", "empathy",
	"recognition", "mutuality", "inclusion", "order", "competence",
]

const REQUEST_PATTERNS := [
	"would you be willing", "could you", "would you", "i'd like to ask",
	"would it work for you", "how would you feel about", "i would appreciate if",
	"i'd appreciate it if", "can we", "could we", "would it be possible",
	"i'd like to request", "i'm wondering if you'd",
]

const BLAME_PATTERNS := [
	"you always", "you never", "you should", "you make me", "you're being",
	"it's your fault", "why can't you", "why don't you", "you need to",
	"you have to", "you must", "you ought to",
]

const JUDGMENT_PATTERNS := [
	"you're so ", "you are so ", "that's so ", "you're a ", "you are a ",
	"how dare you", "what's wrong with you", "you're the worst",
	"you don't care", "you're selfish", "you're lazy", "you're rude",
	"you're inconsiderate", "you're irresponsible",
]

const OBSERVATION_PATTERNS := [
	"when i see", "when i hear", "when i notice", "i noticed that",
	"i observed", "when i saw", "i see that", "i hear that",
	"the last time", "this morning when", "yesterday when",
	"when you said", "when you did",
]

const FEELING_PATTERNS := [
	"i feel ", "i'm feeling ", "i felt ", "i've been feeling ",
	"it makes me feel ", "i am feeling ", "that leaves me feeling ",
]

const NEED_PATTERNS := [
	"i need ", "i value ", "because i need", "because i value",
	"what i need is", "it's important to me", "i have a need for",
	"because my need for",
]

# ─── Scenarios ───
var scenarios := [
	{
		"title": "The Unwashed Dishes",
		"difficulty": "Guided",
		"situation": "You come home after a long day to find your roommate has left a pile of dirty dishes in the sink — for the third day in a row. The kitchen smells, and you can't prepare your dinner.",
		"context": "Your roommate is generally considerate, but has been stressed with a work deadline.",
		"hint": "[color=#4ecdc4]NVC Tip:[/color] Try using this structure:\n• [color=#ffb74d]Observation:[/color] \"When I see [specific behavior]...\"\n• [color=#ffb74d]Feeling:[/color] \"I feel [emotion]...\"\n• [color=#ffb74d]Need:[/color] \"...because I need [value]...\"\n• [color=#ffb74d]Request:[/color] \"Would you be willing to [specific action]?\"",
		"example": "When I see dishes in the sink for three days, I feel frustrated because I need a clean space to prepare meals. Would you be willing to wash your dishes by the end of each day?",
	},
	{
		"title": "Credit Where It's Due",
		"difficulty": "Guided",
		"situation": "During a team meeting, your coworker presented your idea for the new project approach as their own. Your manager praised them for the 'innovative thinking.' You worked on this idea for weeks.",
		"context": "This coworker is someone you generally get along with. You'll need to continue working together.",
		"hint": "[color=#4ecdc4]NVC Tip:[/color] Stay with observations, not stories about intent.\n• What exactly happened? (not \"they stole my idea\")\n• How do you feel? (not \"they're dishonest\")\n• What do you need? (recognition? fairness?)\n• What specific action would help?",
		"example": "When I heard my project approach presented without mention of my contribution, I felt hurt and disappointed because I value recognition for my work. Could we talk about how to credit ideas going forward?",
	},
	{
		"title": "The Forgotten Anniversary",
		"difficulty": "Intermediate",
		"situation": "Your partner completely forgot your anniversary. No card, no mention of it, nothing. When you brought it up, they said, \"Oh, I've been so busy with work. It's just a date.\"",
		"context": "You've been together for several years. They've remembered in previous years.",
		"hint": "",
		"example": "",
	},
	{
		"title": "Cancelled Again",
		"difficulty": "Intermediate",
		"situation": "Your close friend has cancelled plans with you for the third time in two months — each time with a last-minute text. This time, you had already driven to the restaurant and were waiting.",
		"context": "This friendship matters to you, and your friend has been going through some personal changes.",
		"hint": "",
		"example": "",
	},
	{
		"title": "The Late-Night Neighbor",
		"difficulty": "Intermediate",
		"situation": "Your neighbor has been playing loud bass-heavy music past midnight on weeknights. You have to wake up at 6 AM for work, and you've been losing sleep for two weeks. You see them in the hallway.",
		"context": "You've never spoken to this neighbor before. They moved in recently.",
		"hint": "",
		"example": "",
	},
	{
		"title": "The Broken Promise",
		"difficulty": "Advanced",
		"situation": "Your teenage child promised to clean their room before having friends over. You come home to find their friends there, the room untouched, and food wrappers on the floor. They say, \"I was going to do it later, relax.\"",
		"context": "You want to maintain a trusting relationship with your teen while also upholding household agreements.",
		"hint": "",
		"example": "",
	},
	{
		"title": "The Missed Deadline",
		"difficulty": "Advanced",
		"situation": "A team member missed a critical deadline on a component you needed to complete your part of a client project. The client is now unhappy, and your manager has asked you what happened. The team member says they \"didn't realize it was urgent.\"",
		"context": "You sent two reminder emails. The team dynamic matters for future projects.",
		"hint": "",
		"example": "",
	},
	{
		"title": "The Line Cutter",
		"difficulty": "Advanced",
		"situation": "You've been waiting in a long checkout line for 20 minutes. Someone walks up and steps directly in front of you, pretending they don't see the line. Others behind you are looking at you expectantly.",
		"context": "This is a stranger. There's social pressure. You want to be both honest and respectful.",
		"hint": "",
		"example": "",
	},
]

# ─── State ───
var current_scenario: int = 0
var has_submitted: bool = false
var score_history: Array = []  # array of {obs, feel, need, req, blame} per scenario

# ─── UI Nodes ───
var header_label: Label
var progress_label: Label
var difficulty_label: Label
var scenario_title: RichTextLabel
var scenario_text: RichTextLabel
var hint_panel: PanelContainer
var hint_text: RichTextLabel
var feedback_scroll: ScrollContainer
var feedback_text: RichTextLabel
var input_label: Label
var input_field: TextEdit
var submit_btn: Button
var next_btn: Button
var example_btn: Button
var score_display: Label


func _ready():
	_build_ui()
	_show_scenario()


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event is InputEventKey and event.pressed and event.keycode == KEY_R:
		current_scenario = 0
		has_submitted = false
		score_history.clear()
		_show_scenario()
	# Ctrl+Enter to submit
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		if event.ctrl_pressed and not has_submitted:
			_on_submit()


# ─── UI Construction ───

func _build_ui():
	# Root setup
	set_anchors_preset(PRESET_FULL_RECT)
	var bg := ColorRect.new()
	bg.color = BG_COLOR
	bg.set_anchors_preset(PRESET_FULL_RECT)
	add_child(bg)

	# Main layout
	var margin := MarginContainer.new()
	margin.set_anchors_preset(PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 40)
	margin.add_theme_constant_override("margin_right", 40)
	margin.add_theme_constant_override("margin_top", 15)
	margin.add_theme_constant_override("margin_bottom", 15)
	add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 10)
	margin.add_child(vbox)

	# ── Header Row ──
	var header_row := HBoxContainer.new()
	header_row.add_theme_constant_override("separation", 15)
	vbox.add_child(header_row)

	header_label = Label.new()
	header_label.text = "NVC Practice"
	header_label.add_theme_font_size_override("font_size", 28)
	header_label.add_theme_color_override("font_color", ACCENT)
	header_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	header_row.add_child(header_label)

	difficulty_label = Label.new()
	difficulty_label.add_theme_font_size_override("font_size", 18)
	difficulty_label.add_theme_color_override("font_color", TEXT_DIM)
	header_row.add_child(difficulty_label)

	progress_label = Label.new()
	progress_label.add_theme_font_size_override("font_size", 18)
	progress_label.add_theme_color_override("font_color", TEXT_DIM)
	header_row.add_child(progress_label)

	score_display = Label.new()
	score_display.add_theme_font_size_override("font_size", 18)
	score_display.add_theme_color_override("font_color", GOLD)
	header_row.add_child(score_display)

	# ── Separator ──
	var sep1 := HSeparator.new()
	sep1.add_theme_color_override("separator_color", ACCENT_DIM)
	vbox.add_child(sep1)

	# ── Scenario Panel ──
	var scenario_panel := _make_panel(PANEL_COLOR)
	scenario_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scenario_panel.custom_minimum_size.y = 120
	vbox.add_child(scenario_panel)

	var scenario_vbox := VBoxContainer.new()
	scenario_vbox.add_theme_constant_override("separation", 8)
	scenario_panel.add_child(scenario_vbox)

	scenario_title = RichTextLabel.new()
	scenario_title.bbcode_enabled = true
	scenario_title.fit_content = true
	scenario_title.scroll_active = false
	scenario_title.add_theme_font_size_override("normal_font_size", 20)
	scenario_title.add_theme_color_override("default_color", TEXT_WARM)
	scenario_vbox.add_child(scenario_title)

	scenario_text = RichTextLabel.new()
	scenario_text.bbcode_enabled = true
	scenario_text.fit_content = true
	scenario_text.scroll_active = false
	scenario_text.add_theme_font_size_override("normal_font_size", 17)
	scenario_text.add_theme_color_override("default_color", TEXT_COLOR)
	scenario_vbox.add_child(scenario_text)

	# ── Hint Panel (shown for guided scenarios) ──
	hint_panel = _make_panel(PANEL_LIGHT)
	hint_panel.custom_minimum_size.y = 0
	vbox.add_child(hint_panel)

	hint_text = RichTextLabel.new()
	hint_text.bbcode_enabled = true
	hint_text.fit_content = true
	hint_text.scroll_active = false
	hint_text.add_theme_font_size_override("normal_font_size", 15)
	hint_text.add_theme_color_override("default_color", TEXT_DIM)
	hint_panel.add_child(hint_text)

	# ── Feedback Area ──
	feedback_scroll = ScrollContainer.new()
	feedback_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	feedback_scroll.custom_minimum_size.y = 100
	feedback_scroll.visible = false
	vbox.add_child(feedback_scroll)

	var feedback_panel := _make_panel(PANEL_LIGHT)
	feedback_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	feedback_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	feedback_scroll.add_child(feedback_panel)

	feedback_text = RichTextLabel.new()
	feedback_text.bbcode_enabled = true
	feedback_text.fit_content = true
	feedback_text.scroll_active = false
	feedback_text.add_theme_font_size_override("normal_font_size", 16)
	feedback_text.add_theme_color_override("default_color", TEXT_COLOR)
	feedback_panel.add_child(feedback_text)

	# ── Separator ──
	var sep2 := HSeparator.new()
	sep2.add_theme_color_override("separator_color", Color(1, 1, 1, 0.1))
	vbox.add_child(sep2)

	# ── Input Area ──
	input_label = Label.new()
	input_label.text = "Your response:"
	input_label.add_theme_font_size_override("font_size", 16)
	input_label.add_theme_color_override("font_color", ACCENT)
	vbox.add_child(input_label)

	input_field = TextEdit.new()
	input_field.placeholder_text = "Type your NVC response here... (Ctrl+Enter to submit)"
	input_field.custom_minimum_size.y = 80
	input_field.size_flags_vertical = Control.SIZE_SHRINK_END
	input_field.add_theme_font_size_override("font_size", 16)
	input_field.add_theme_color_override("font_color", TEXT_COLOR)
	input_field.add_theme_color_override("background_color", PANEL_COLOR)
	var input_sb := StyleBoxFlat.new()
	input_sb.bg_color = PANEL_COLOR
	input_sb.border_color = ACCENT_DIM
	input_sb.set_border_width_all(2)
	input_sb.set_corner_radius_all(6)
	input_sb.set_content_margin_all(10)
	input_field.add_theme_stylebox_override("normal", input_sb)
	input_field.add_theme_stylebox_override("focus", input_sb)
	vbox.add_child(input_field)

	# ── Button Row ──
	var btn_row := HBoxContainer.new()
	btn_row.add_theme_constant_override("separation", 12)
	btn_row.alignment = BoxContainer.ALIGNMENT_END
	vbox.add_child(btn_row)

	example_btn = _make_button("Show Example", HEADER_COLOR)
	example_btn.pressed.connect(_on_show_example)
	example_btn.visible = false
	btn_row.add_child(example_btn)

	# Spacer
	var spacer := Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	btn_row.add_child(spacer)

	submit_btn = _make_button("Submit Response", ACCENT_DIM)
	submit_btn.pressed.connect(_on_submit)
	btn_row.add_child(submit_btn)

	next_btn = _make_button("Next Scenario →", ACCENT_DIM)
	next_btn.pressed.connect(_on_next)
	next_btn.visible = false
	btn_row.add_child(next_btn)


func _make_panel(color: Color) -> PanelContainer:
	var panel := PanelContainer.new()
	var sb := StyleBoxFlat.new()
	sb.bg_color = color
	sb.set_corner_radius_all(8)
	sb.set_content_margin_all(16)
	panel.add_theme_stylebox_override("panel", sb)
	return panel


func _make_button(text: String, color: Color) -> Button:
	var btn := Button.new()
	btn.text = text
	btn.add_theme_font_size_override("font_size", 16)
	btn.custom_minimum_size = Vector2(180, 40)
	var sb := StyleBoxFlat.new()
	sb.bg_color = color
	sb.set_corner_radius_all(6)
	sb.set_content_margin_all(8)
	btn.add_theme_stylebox_override("normal", sb)
	var sb_hover := sb.duplicate()
	sb_hover.bg_color = color.lightened(0.15)
	btn.add_theme_stylebox_override("hover", sb_hover)
	var sb_pressed := sb.duplicate()
	sb_pressed.bg_color = color.darkened(0.15)
	btn.add_theme_stylebox_override("pressed", sb_pressed)
	btn.add_theme_color_override("font_color", TEXT_COLOR)
	btn.add_theme_color_override("font_hover_color", Color.WHITE)
	return btn


# ─── Game Logic ───

func _show_scenario():
	has_submitted = false
	var s: Dictionary = scenarios[current_scenario]

	progress_label.text = "Scenario %d / %d" % [current_scenario + 1, scenarios.size()]
	difficulty_label.text = "[%s]" % s["difficulty"]
	_update_score_display()

	scenario_title.text = "[b]%s[/b]" % s["title"]
	scenario_text.text = "%s\n\n[color=#8899aa][i]Context: %s[/i][/color]" % [s["situation"], s["context"]]

	if s["hint"] != "":
		hint_panel.visible = true
		hint_text.text = s["hint"]
	else:
		hint_panel.visible = false

	feedback_scroll.visible = false
	feedback_text.text = ""
	input_field.text = ""
	input_field.editable = true
	submit_btn.visible = true
	submit_btn.disabled = false
	next_btn.visible = false
	example_btn.visible = s["example"] != ""
	example_btn.disabled = false

	input_field.grab_focus()


func _on_submit():
	if input_field.text.strip_edges().length() < 10:
		feedback_scroll.visible = true
		feedback_text.text = "[color=#ef5350]Please write a longer response (at least a sentence or two).[/color]"
		return

	has_submitted = true
	input_field.editable = false
	submit_btn.visible = false
	next_btn.visible = true

	var result := _evaluate(input_field.text)
	score_history.append(result)
	_show_feedback(result)
	_update_score_display()

	if current_scenario < scenarios.size() - 1:
		next_btn.text = "Next Scenario →"
	else:
		next_btn.text = "View Final Summary"


func _on_next():
	current_scenario += 1
	if current_scenario >= scenarios.size():
		_show_summary()
	else:
		_show_scenario()


func _on_show_example():
	var s: Dictionary = scenarios[current_scenario]
	if s["example"] != "":
		hint_text.text += "\n\n[color=#66bb6a][b]Example response:[/b][/color]\n[i]\"%s\"[/i]" % s["example"]
		example_btn.disabled = true


# ─── NVC Evaluation Engine ───

func _evaluate(response: String) -> Dictionary:
	var lower := response.to_lower()
	var result := {
		"observation": false,
		"feeling": false,
		"need": false,
		"request": false,
		"blame_count": 0,
		"judgment_count": 0,
		"blame_examples": [],
		"observation_detail": "",
		"feeling_detail": "",
		"need_detail": "",
		"request_detail": "",
	}

	# Check for observation language
	for pat in OBSERVATION_PATTERNS:
		if lower.find(pat) != -1:
			result["observation"] = true
			result["observation_detail"] = pat
			break

	# Check for feeling language
	for pat in FEELING_PATTERNS:
		if lower.find(pat) != -1:
			result["feeling"] = true
			break
	if not result["feeling"]:
		for word in FEELING_WORDS:
			if _word_present(lower, word):
				result["feeling"] = true
				result["feeling_detail"] = word
				break

	# Check for need language
	for pat in NEED_PATTERNS:
		if lower.find(pat) != -1:
			result["need"] = true
			break
	if not result["need"]:
		for word in NEED_WORDS:
			if _word_present(lower, word):
				result["need"] = true
				result["need_detail"] = word
				break

	# Check for request language
	for pat in REQUEST_PATTERNS:
		if lower.find(pat) != -1:
			result["request"] = true
			result["request_detail"] = pat
			break

	# Check for blame patterns
	for pat in BLAME_PATTERNS:
		if lower.find(pat) != -1:
			result["blame_count"] += 1
			result["blame_examples"].append(pat)

	# Check for judgment patterns
	for pat in JUDGMENT_PATTERNS:
		if lower.find(pat) != -1:
			result["judgment_count"] += 1
			result["blame_examples"].append(pat)

	return result


func _word_present(text: String, word: String) -> bool:
	# Check if word appears as a standalone word (not part of another word)
	var idx := text.find(word)
	if idx == -1:
		return false
	# Check boundaries
	if idx > 0 and text[idx - 1].is_valid_identifier():
		return false
	var end_idx := idx + word.length()
	if end_idx < text.length() and text[end_idx].is_valid_identifier():
		return false
	return true


# ─── Feedback Display ───

func _show_feedback(r: Dictionary):
	feedback_scroll.visible = true

	var stars := 0
	var fb := ""

	# Overall tone
	var has_blame: bool = r["blame_count"] > 0 or r["judgment_count"] > 0
	if has_blame:
		fb += "[color=#ef5350]⚠ Blame/Judgment Detected[/color]\n"
		fb += "[color=#ef5350]Phrases like \"%s\" can make the other person defensive. " % r["blame_examples"][0]
		fb += "Try describing specific behaviors instead of generalizing.[/color]\n\n"
	else:
		fb += "[color=#66bb6a]✓ No blame or judgment language detected — great![/color]\n\n"
		stars += 1

	# Observation
	fb += "[b][color=#ffb74d]1. Observation[/color][/b] — "
	if r["observation"]:
		fb += "[color=#66bb6a]✓ Found![/color]\n"
		fb += "Good — you described what happened specifically rather than interpreting it.\n\n"
		stars += 1
	else:
		fb += "[color=#ef5350]Not clearly detected[/color]\n"
		fb += "Try starting with a concrete observation: [i]\"When I see/hear [specific thing]...\"[/i]\n"
		fb += "This separates facts from evaluations and makes your message easier to hear.\n\n"

	# Feeling
	fb += "[b][color=#ffb74d]2. Feeling[/color][/b] — "
	if r["feeling"]:
		fb += "[color=#66bb6a]✓ Found![/color]\n"
		fb += "You named your emotional experience, which builds connection and vulnerability.\n\n"
		stars += 1
	else:
		fb += "[color=#ef5350]Not clearly detected[/color]\n"
		fb += "Try naming how you feel: [i]\"I feel frustrated / hurt / disappointed / anxious...\"[/i]\n"
		fb += "Owning your feelings (\"I feel...\") is different from thoughts disguised as feelings (\"I feel that you...\").\n\n"

	# Need
	fb += "[b][color=#ffb74d]3. Need[/color][/b] — "
	if r["need"]:
		fb += "[color=#66bb6a]✓ Found![/color]\n"
		fb += "Connecting feelings to universal human needs helps the other person understand your motivation.\n\n"
		stars += 1
	else:
		fb += "[color=#ef5350]Not clearly detected[/color]\n"
		fb += "Try connecting to an underlying need: [i]\"...because I need/value respect / trust / cooperation / rest...\"[/i]\n"
		fb += "Needs are universal — naming them moves the conversation from blame to shared humanity.\n\n"

	# Request
	fb += "[b][color=#ffb74d]4. Request[/color][/b] — "
	if r["request"]:
		fb += "[color=#66bb6a]✓ Found![/color]\n"
		fb += "A clear, doable request gives the other person a way to respond constructively.\n\n"
		stars += 1
	else:
		fb += "[color=#ef5350]Not clearly detected[/color]\n"
		fb += "End with a specific, actionable request: [i]\"Would you be willing to...?\"[/i]\n"
		fb += "Requests (not demands) respect the other person's autonomy and invite collaboration.\n\n"

	# Star rating
	var star_str := ""
	for i in range(5):
		if i < stars:
			star_str += "★ "
		else:
			star_str += "☆ "

	var rating_color := GREEN if stars >= 4 else (AMBER if stars >= 2 else RED)
	fb += "[b][color=#%s]Score: %s(%d/5)[/color][/b]\n" % [rating_color.to_html(false), star_str, stars]

	# Encouragement
	if stars == 5:
		fb += "[color=#66bb6a]Excellent! Your response demonstrates all four NVC components beautifully.[/color]"
	elif stars >= 3:
		fb += "[color=#ffb74d]Good effort! You're on the right track. Review the missing components above.[/color]"
	elif stars >= 1:
		fb += "[color=#ffb74d]A good start — keep practicing the NVC structure. It gets more natural over time.[/color]"
	else:
		fb += "[color=#ef5350]This is a learning process! Try restructuring your response using the four NVC steps.[/color]"

	feedback_text.text = fb


func _update_score_display():
	if score_history.is_empty():
		score_display.text = ""
		return
	var total_stars := 0
	var max_stars := score_history.size() * 5
	for r in score_history:
		if not (r["blame_count"] > 0 or r["judgment_count"] > 0):
			total_stars += 1
		if r["observation"]:
			total_stars += 1
		if r["feeling"]:
			total_stars += 1
		if r["need"]:
			total_stars += 1
		if r["request"]:
			total_stars += 1
	score_display.text = "Total: %d/%d ★" % [total_stars, max_stars]


# ─── Final Summary ───

func _show_summary():
	# Replace the whole UI with a summary screen
	var total := 0
	var maximum := score_history.size() * 5
	var component_totals := {"observation": 0, "feeling": 0, "need": 0, "request": 0, "no_blame": 0}

	for r in score_history:
		if not (r["blame_count"] > 0 or r["judgment_count"] > 0):
			component_totals["no_blame"] += 1
			total += 1
		for key in ["observation", "feeling", "need", "request"]:
			if r[key]:
				component_totals[key] += 1
				total += 1

	scenario_title.text = "[b]Practice Complete![/b]"
	hint_panel.visible = false
	input_field.visible = false
	input_label.visible = false
	submit_btn.visible = false
	next_btn.visible = false
	example_btn.visible = false

	var n: int = score_history.size()
	var pct: int = int(float(total) / float(maximum) * 100.0) if maximum > 0 else 0

	var summary := "[b]Your NVC Journey — %d Scenarios Completed[/b]\n\n" % n
	summary += "[color=#ffd54f]Overall Score: %d / %d  (%d%%)[/color]\n\n" % [total, maximum, pct]

	summary += "[b]Component Breakdown:[/b]\n"
	summary += "  [color=#ffb74d]Observations:[/color]     %d / %d\n" % [component_totals["observation"], n]
	summary += "  [color=#ffb74d]Feelings:[/color]         %d / %d\n" % [component_totals["feeling"], n]
	summary += "  [color=#ffb74d]Needs:[/color]            %d / %d\n" % [component_totals["need"], n]
	summary += "  [color=#ffb74d]Requests:[/color]         %d / %d\n" % [component_totals["request"], n]
	summary += "  [color=#ffb74d]No Blame/Judgment:[/color] %d / %d\n\n" % [component_totals["no_blame"], n]

	# Identify strengths and growth areas
	var best_score := 0
	var best_name := ""
	var worst_score := n
	var worst_name := ""
	var names := {"observation": "Observations", "feeling": "Feelings", "need": "Needs", "request": "Requests", "no_blame": "Non-judgmental language"}
	for key in component_totals:
		if component_totals[key] >= best_score:
			best_score = component_totals[key]
			best_name = names[key]
		if component_totals[key] <= worst_score:
			worst_score = component_totals[key]
			worst_name = names[key]

	summary += "[color=#66bb6a]★ Strength: %s[/color]\n" % best_name
	if worst_score < n:
		summary += "[color=#ffb74d]→ Growth area: %s[/color]\n\n" % worst_name

	if pct >= 80:
		summary += "[color=#66bb6a]Outstanding! You have a strong grasp of NVC principles.[/color]"
	elif pct >= 60:
		summary += "[color=#ffb74d]Great progress! Keep practicing, especially your growth areas.[/color]"
	else:
		summary += "[color=#ffb74d]NVC is a skill that deepens with practice. You've taken a wonderful first step.[/color]"

	summary += "\n\n[color=#8899aa]Press R to start over with new responses.[/color]"

	scenario_text.text = ""
	feedback_scroll.visible = true
	feedback_text.text = summary
	progress_label.text = "Complete!"

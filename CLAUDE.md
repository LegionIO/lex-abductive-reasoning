# lex-abductive-reasoning

**Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Peirce abductive reasoning engine — inference to the best explanation for brain-modeled agentic AI. Models the cognitive process of generating and ranking hypotheses that best explain observed phenomena, implementing the classic triad of observation, hypothesis generation, and evidence evaluation.

## Gem Info

- **Gem name**: `lex-abductive-reasoning`
- **Version**: `0.1.0`
- **Module**: `Legion::Extensions::AbductiveReasoning`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/abductive_reasoning/
  abductive_reasoning.rb       # Main extension module, requires all sub-files
  version.rb                   # VERSION = '0.1.0'
  client.rb                    # Client wrapper
  helpers/
    constants.rb               # MAX_OBSERVATIONS, MAX_HYPOTHESES, scoring weights, labels
    observation.rb             # Observation value object (id, content, domain, surprise_level)
    hypothesis.rb              # Hypothesis value object (scoring, evidence tracking, state)
    abduction_engine.rb        # Core engine: manages observations and hypotheses, decay/prune
  runners/
    abductive_reasoning.rb     # Runner module with 8 public methods
spec/
  (spec files)
```

## Key Constants

```ruby
MAX_OBSERVATIONS      = 200
MAX_HYPOTHESES        = 100
DEFAULT_PLAUSIBILITY  = 0.5
SIMPLICITY_WEIGHT     = 0.3
EXPLANATORY_POWER_WEIGHT = 0.4
PRIOR_WEIGHT          = 0.3
EVIDENCE_BOOST        = 0.1
CONTRADICTION_PENALTY = 0.2
DECAY_RATE            = 0.02
STALE_THRESHOLD       = 120   # seconds before hypothesis starts decaying
SURPRISE_LEVELS       = %i[trivial expected notable surprising shocking]
HYPOTHESIS_STATES     = %i[candidate supported refuted]
QUALITY_LABELS        = { (0.8..) => :compelling, ... (..0.2) => :implausible }
```

## Runners

### `Runners::AbductiveReasoning`

All methods delegate to a private `@engine` (`Helpers::AbductionEngine` instance).

- `record_observation(content:, domain:, surprise_level: :notable, context: {})` — creates and stores an Observation
- `generate_hypothesis(content:, observation_ids:, domain:, simplicity:, explanatory_power:, prior_probability: nil)` — creates a Hypothesis with weighted scoring
- `evaluate_hypothesis(hypothesis_id:)` — scores hypothesis, returns rank among competing hypotheses for same observations
- `add_hypothesis_evidence(hypothesis_id:, supporting:)` — adds supporting/contradicting evidence; auto-promotes to `:supported` at 3 supporting evidences
- `best_explanation(observation_id:)` — returns the highest-scoring non-refuted hypothesis for an observation
- `competing_hypotheses(observation_id:)` — returns all non-refuted hypotheses ranked by score
- `refute_hypothesis(hypothesis_id:)` — marks hypothesis as `:refuted`
- `unexplained_observations` — observations with no `:supported` hypothesis
- `update_abductive_reasoning` — decay stale hypotheses, prune refuted ones
- `abductive_reasoning_stats` — engine statistics hash

## Helpers

### `Helpers::AbductionEngine`
Core engine managing `@observations` and `@hypotheses` hashes. Prunes oldest candidates when at capacity. Implements `decay_stale` (reduces plausibility of hypotheses not evaluated within `STALE_THRESHOLD` seconds) and `prune_refuted`.

### `Helpers::Hypothesis`
Value object. `overall_score` = weighted sum of simplicity, explanatory_power, and prior_probability. `add_evidence` adjusts plausibility and auto-transitions state. `SUPPORT_EVIDENCE_THRESHOLD = 3`.

### `Helpers::Observation`
Value object. Stores content, domain, surprise_level, context, and created_at.

## Integration Points

No actors defined — this extension is driven by explicit calls. Integrates into the lex-tick cognitive pipeline as a reasoning module callable from the `action_selection` or custom phases. lex-cortex can wire it into any phase that needs inference-to-best-explanation logic.

## Development Notes

- Hypothesis scoring is static (computed from initial parameters); plausibility is the mutable field affected by evidence and decay
- `overall_score` uses `simplicity * 0.3 + explanatory_power * 0.4 + prior_probability * 0.3` — these weights are not runtime-configurable
- Pruning on capacity is oldest-first for candidates; refuted hypotheses are pruned by `update_abductive_reasoning`
- No actor defined: callers must invoke `update_abductive_reasoning` periodically for decay/pruning to occur

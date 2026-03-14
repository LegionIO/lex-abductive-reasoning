# lex-abductive-reasoning

Peirce abductive reasoning engine — inference to the best explanation for brain-modeled agentic AI.

## What It Does

Models the cognitive process of abductive inference: given a surprising observation, generate hypotheses that could explain it, evaluate each against evidence, and identify the most plausible explanation. Implements Peirce's classic formulation of abduction as inference to the best explanation. The engine tracks observations, maintains competing hypotheses with weighted scoring, and decays stale hypotheses over time.

## Core Concept: Inference to the Best Explanation

A hypothesis is scored by three weighted factors:

```ruby
overall_score = (0.3 * simplicity) + (0.4 * explanatory_power) + (0.3 * prior_probability)
```

Adding supporting evidence boosts plausibility by `0.1`; contradicting evidence reduces it by `0.2`. A hypothesis transitions from `:candidate` to `:supported` after 3 supporting evidences, and can be explicitly `:refuted`.

## Usage

```ruby
client = Legion::Extensions::AbductiveReasoning::Client.new

# Record a surprising observation
obs = client.record_observation(
  content: 'service latency spiked 10x without deployment',
  domain: :infrastructure,
  surprise_level: :surprising
)

# Generate competing hypotheses
h1 = client.generate_hypothesis(
  content: 'database connection pool exhausted',
  observation_ids: [obs[:observation][:id]],
  domain: :infrastructure,
  simplicity: 0.8,
  explanatory_power: 0.9
)

# Add evidence
client.add_hypothesis_evidence(hypothesis_id: h1[:hypothesis][:id], supporting: true)

# Find the best explanation
result = client.best_explanation(observation_id: obs[:observation][:id])
# => { success: true, found: true, hypothesis: { id: ..., quality_label: :compelling, ... } }

# Maintenance cycle (decay stale, prune refuted)
client.update_abductive_reasoning
```

## Integration

Wires into lex-tick phases via lex-cortex phase handler injection. Useful in `action_selection` and reasoning phases where the agent needs to explain unexpected observations before deciding on a response.

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT

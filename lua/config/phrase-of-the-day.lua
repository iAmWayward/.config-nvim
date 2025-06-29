local quotes = {
	taoist = {
		{
			text = "The journey of a thousand miles begins with one step.",
			author = "Lao Tzu",
		},
		{
			text = "When I let go of what I am, I become what I might be.",
			author = "Lao Tzu",
		},
		{
			text = "Water is fluid, soft, and yielding. But water will wear away rock, which cannot yield.",
			author = "Lao Tzu",
		},
		{
			text = "The wise find pleasure in water; the virtuous find pleasure in hills.",
			author = "Confucius",
		},
		{
			text = "He who knows that enough is enough will always have enough.",
			author = "Lao Tzu",
		},
		{
			text = "Empty your mind, be formless. Shapeless, like water.",
			author = "Bruce Lee",
		},
		{
			text = "The sage does not attempt anything very big, and thus achieves greatness.",
			author = "Lao Tzu",
		},
		{
			text = "Nature does not hurry, yet everything is accomplished.",
			author = "Lao Tzu",
		},
		{
			text = "Those who flow as life flows know they need no other force.",
			author = "Lao Tzu",
		},
		{
			text = "The truth is not always beautiful, nor beautiful words the truth.",
			author = "Lao Tzu",
		},
	},
	buddhist = {
		{
			text = "The mind is everything. What you think you become.",
			author = "Buddha",
		},
		{
			text = "Peace comes from within. Do not seek it without.",
			author = "Buddha",
		},
		{
			text = "Three things cannot be long hidden: the sun, the moon, and the truth.",
			author = "Buddha",
		},
		{
			text = "Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment.",
			author = "Buddha",
		},
		{
			text = "Hatred does not cease by hatred, but only by love; this is the eternal rule.",
			author = "Buddha",
		},
		{
			text = "Health is the greatest gift, contentment the greatest wealth, faithfulness the best relationship.",
			author = "Buddha",
		},
		{
			text = "The only real failure in life is not to be true to the best one knows.",
			author = "Buddha",
		},
		{
			text = "Better than a thousand hollow words, is one word that brings peace.",
			author = "Buddha",
		},
		{
			text = "If you truly loved yourself, you could never hurt another.",
			author = "Buddha",
		},
		{
			text = "Pain is certain, suffering is optional.",
			author = "Buddha",
		},
		{
			text = "Work out your salvation. Do not depend on others.",
			author = "Buddha",
		},
		{
			text = "Every morning we are born again. What we do today is what matters most.",
			author = "Buddha",
		},
	},
}

-- Helper function to get a random quote from either tradition
function getRandomQuote(tradition)
	if tradition == "taoist" or tradition == "buddhist" then
		local quoteList = quotes[tradition]
		local randomIndex = math.random(1, #quoteList)
		return quoteList[randomIndex]
	elseif tradition == "any" or tradition == nil then
		local allQuotes = {}
		for _, quote in ipairs(quotes.taoist) do
			table.insert(allQuotes, quote)
		end
		for _, quote in ipairs(quotes.buddhist) do
			table.insert(allQuotes, quote)
		end
		local randomIndex = math.random(1, #allQuotes)
		return allQuotes[randomIndex]
	else
		return nil
	end
end

-- Helper function to print a formatted quote
-- Example usage:
-- math.randomseed(os.time()) -- Seed for random number generation
-- local randomTaoistQuote = getRandomQuote("taoist")
-- local randomBuddhistQuote = getRandomQuote("buddhist")
-- local randomAnyQuote = getRandomQuote("any")
--
-- printQuote(randomTaoistQuote)
-- print()
-- printQuote(randomBuddhistQuote)

return quotes

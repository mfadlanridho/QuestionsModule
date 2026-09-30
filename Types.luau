--!strict

export type AnswerMap = { [string]: number }

export type Question = {
	id: string,
	category: string,
	prompt: string,
	answers: AnswerMap,
}

return nil

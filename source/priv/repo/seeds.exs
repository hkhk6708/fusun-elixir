# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fusun.Repo.insert!(%Fusun.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Fusun.Repo.insert!(
	%Fusun.Model.User{
		username: "dylan", 
		password: "$2b$12$.l5pKmxwHnLqt4unBm6n4eRgaOk2YVncM2UqMqLX.78AfM4xrEinW",
		email: "dylanho1230@gmail.com",
		phone: "0920656545",
		role: "admin",
		status: 1,
		firstname: "Dylan",
		lastname: "Ho"
	}
)

Fusun.Repo.insert!(
	%Fusun.Model.Product{
		name: "SP SPORT LM704",
		type: "tire",
		description: "",
		price: 200.0,
		provider: "馬牌輪胎",
		size: "225/55",
		code: "LM704-4",
		v_number: "85V",
		radius: "15",
		position: "F"
	}
)

Fusun.Repo.insert!(
	%Fusun.Model.Product{
		name: "SP SPORT LM705",
		type: "tire",
		description: "",
		price: 200.0,
		provider: "馬牌輪胎",
		size: "225/55",
		code: "LM704-4",
		v_number: "85V",
		radius: "15",
		position: "F"
	}
)

Fusun.Repo.insert!(
	%Fusun.Model.Product{
		name: "SP SPORT LM704 Wheel",
		type: "wheel",
		description: "",
		price: 200.0,
		provider: "馬牌輪胎",
		size: "225/55",
		code: "LM704-4",
		v_number: "85V",
		radius: "15",
		position: "F"
	}
)

Fusun.Repo.insert!(
	%Fusun.Model.Product{
		name: "SP SPORT LM705 Wheel",
		type: "wheel",
		description: "",
		price: 200.0,
		provider: "馬牌輪胎",
		size: "225/55",
		code: "LM704-4",
		v_number: "85V",
		radius: "15",
		position: "F"
	}
)
### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ c478e208-c19b-11ec-0d55-a3ddfacd29e9
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie
end

# ╔═╡ dc57ffc3-0587-4f18-b0b1-3865c89d2f76
set_theme!(Controlz.cool_theme)

# ╔═╡ af6d647a-00e3-4652-ad45-834b6d289131
md"## simulating a set point change under PI control

below is a closed-loop block diagram of a process under PI feedback control for making set point changes.

![](https://raw.githubusercontent.com/SimonEnsemble/CHE461_S2022/main/random/pi_control_loop.png)

* controlled variable: $y$
* set point for controlled variable: $y_{sp}$
* manipulated variable: $u$
* measurement of controlled variable: $y_m$

!!! note
	the `Controlz.jl` example [here](https://simonensemble.github.io/Controlz.jl/dev/controls/#servo-response-of-a-simple-control-system) may be helpful for this studio.

!!! example \"objective\"
	the objective of this studio is to simulate the closed-loop response to a set point change of $+10$ at $t=0$.

🐢 the smart and busy operator PI-controller settings pertain only to first order systems without a sensor. regardless, apply the smart and busy operator PI-controller settings to this closed loop to determine $K_c$ and $\tau_I$ by ignoring the additional dynamics of the sensor. this is justifiable because the sensor is fast compared to the process.
"

# ╔═╡ 38d308da-02cb-48c3-9b3f-fe0dc0d99008


# ╔═╡ 5e49b23b-4776-4f77-b297-73e933d930f1
md"
#### constructing the transfer functions
🐢 first, construct the following as `TransferFunction`'s and assign them as variables.
* the process transfer function $G_u(s)$, as variable `G_u`
* the sensor transfer function $G_s(s)$, as as variable `G_s`
* the set point transfer function $Y_{sp}^*(s)$, as a variable `Y_sp★`
* the controller transfer function $G_c(s)$, as a variable `G_c`
then use `G_u`, `G_c`, `G_s`, and `Y_sp★` to construct:
* the closed-loop transfer function $G_{servo}(s)$, as a variable `G_servo`
* the closed-loop response $Y^*(s)$, as a variable `Y★`
finally, to simulate more details of the closed-loop:
* use `Y★`, `G_s`, and `Y_sp★` to construct the error signal $E(s)$ as a variable `E`
* use `E` to construct:
  * the total controller action $U^*(s)$ as a variable `U★`
  * the P-action contribution to the controller output as a variable `U★_P`
  * the I-action contribution to the controller output as a variable `U★_I`

!!! note
	you can type the `★` with \"\bigstar\", then `Tab`.
"

# ╔═╡ bf51eb42-52ec-43a2-adaa-7e92d215aa85
# process transfer function
G_u = 

# ╔═╡ 7c9f0697-a081-41f0-93b8-45fab58ac4ee
# sensor transfer function
G_s = 

# ╔═╡ fea4e364-a698-4804-81f1-5ddfd27461c4
# PI-controller transfer function
G_c = 

# ╔═╡ a1e6f79b-a7dc-48f1-8d7f-1d8f9488fe3e
# closed-loop servo transfer function
G_servo =

# ╔═╡ 0abc8aeb-3cc7-4757-87c1-d285591cd06b
# the set point change
Y_sp★ = 

# ╔═╡ ad52e463-89ad-4caf-a5bf-b7c6cbd69119
# the closed-loop response to the set point change
#   (use your closed-loop transfer function here!)
Y★ =

# ╔═╡ 162d041c-9318-436f-9cf2-4620cd84f067
# the error signal
E = 

# ╔═╡ d88f94ce-138f-4441-ac30-3b65d02ceae6
# total controller action
U★ = 

# ╔═╡ e29d8abd-cce0-4e98-9652-0d4448f310e1
# P-action
U★_P = 

# ╔═╡ 539e7892-ce27-4c72-815a-e75240b27777
# I-action
U★_I = 

# ╔═╡ f061ef71-7e73-4bb5-a109-4f864435eb9c
md"
#### inspecting the closed-loop transfer function

🐢 use `zero_frequency_gain` (see [docs](https://simonensemble.github.io/Controlz.jl/dev/tfs/#Controlz.zero_frequency_gain)) to compute the gain of the servo transfer function $G_{servo}(s)$. based on the gain, do you expect there to be steady state offset error in the servo response under PI control?
"

# ╔═╡ a8e83f10-4665-42e0-9852-ca66186b46a3


# ╔═╡ 544903a0-bd8f-43c0-a602-fd87ced610ea
md"🐢 visualize the poles and zeros of the transfer function $G_{servo}(s)$ in the complex plane using `viz_poles_and_zeros` (see [docs](https://simonensemble.github.io/Controlz.jl/dev/viz/#poles-and-zeros-of-a-transfer-function)). based on the location of the poles in the complex plane, do you expect the closed loop servo response to exhibit oscillations?"

# ╔═╡ e44ca0b3-f8b2-4c26-849b-759b7bd9fc83


# ╔═╡ 94d57ac7-37db-4036-a2d0-1440df97cb6d
md"
#### simulate (invert into time domain)

🐢 numerically invert each transfer function, `Y★`, `Y_sp★`, `E`, `U★`, `U★_P`, and `U★_I`, into the time domain using `simulate` and assign the output to a data frame. e.g.
```julia
> data_y★ = simulate(Y★, final_time)
```
. we will plot the data next.
"

# ╔═╡ 15f9d484-62bd-404f-8ebe-52300742a674
final_time = 15.0 # how long to run the simulation

# ╔═╡ 06a3fd80-422d-4917-9c28-555eb37f1862
begin
	data_y★    = simulate(Y★, final_time)
	data_y_sp★ = simulate(Y_sp★, final_time)
	data_e     = simulate(E, final_time)
	data_u★    = simulate(U★, final_time)
	data_u★_p  = simulate(U★_P, final_time)
	data_u★_i  = simulate(U★_I, final_time)
end

# ╔═╡ a76dfcd0-7ad6-4232-9022-ba355d69565b


# ╔═╡ bd986b69-6b61-4191-a98a-8b9dedfa1abd
md"#### visualize the closed-loop response

the Makie code below will visualize the closed-loop response.
"

# ╔═╡ 429a8b0e-7b28-439f-bf84-231545219336
begin
	fig = Figure(resolution=(520, 785))
	axs  = [
		Axis(fig[1, 1], title="error signal", ylabel="e*(t)"),
		Axis(fig[2, 1], title="controller action", ylabel="u*(t)"),
		Axis(fig[3, 1], title="closed-loop response", xlabel="time, t", ylabel="y*(t)")
	]
	linkxaxes!(axs...)
	hidexdecorations!(axs[1], grid=false)
	hidexdecorations!(axs[2], grid=false)
	
	lines!(axs[1], data_e[:, "t"], data_e[:, "output"], color=Cycled(5))

	lines!(axs[2], data_u★[:, "t"], data_u★[:, "output"], color=Cycled(2))
	lines!(axs[2], data_u★_p[:, "t"], data_u★_p[:, "output"], 
		color=Cycled(2), linestyle=:dot, label="P-action", linewidth=2)
	lines!(axs[2], data_u★_i[:, "t"], data_u★_i[:, "output"], 
		color=Cycled(2), linestyle=:dash, label="I-action", linewidth=2)
	axislegend(axs[2], position=:rc)
	
	lines!(axs[3], data_y★[:, "t"],   data_y★[:, "output"])
	lines!(axs[3], data_y_sp★[:, "t"], data_y_sp★[:, "output"], 
		linestyle=:dot, label="set point", color=Cycled(3))
	axislegend(axs[3], position=:rb)
	xlims!(minimum(data_y★[:, "t"]), maximum(data_y★[:, "t"]))
	
	fig
end

# ╔═╡ 90115b83-057c-4457-a2a9-584252606976
md"#### interpret, explain the response
🐢 answer the questions below by editing this cell.

❓ does the controller action result in that of a smart and busy operator? (_hint_: no, why?)

❓ immediately after the set point change is made, does the controller increase or decrease the manipulated variable to bring the controlled variable towards the new set point? explain why.

❓ when is P-action the largest? why? when is it the smallest?

❓ when is I-action the largest? why? when is it the smallest?

❓ after the controlled variable has reached its new steady-state, what is the value of P-action? why? what is the value of I-action?

❓ does the controlled variable eventually reach its new set point? what is the steady state offset error?

❓ what is the clear qualitative benefit of adding I-action to P-action?
"

# ╔═╡ f5762ff1-f0da-46a2-9dc9-b470c80bb919
md"
#### playing with $K_c$ and $\tau_I$
🐢 halve $\tau_I$.

❓ what changes do you observe in (a) the closed-loop response to the set point change and (b) the poles of the closed-loop transfer function?

🐢 now both divide $\tau_I$ by 6 and multiply the controller gain by 6. this gives a very aggressive controller with strong I-action. 💪

❓ what changes do you observe in (a) the closed-loop response to the set point change and (b) the poles of the closed-loop transfer function? 👀
"

# ╔═╡ 293d7aae-02e8-49a2-acdb-b57aed59dcbe
md"
!!! warning \"before you turn in.\"
	to facilitate scoring, set `K_c` and `τ_I` as the initial settings obtained from the smart and busy operator settings.
"

# ╔═╡ Cell order:
# ╠═c478e208-c19b-11ec-0d55-a3ddfacd29e9
# ╠═dc57ffc3-0587-4f18-b0b1-3865c89d2f76
# ╟─af6d647a-00e3-4652-ad45-834b6d289131
# ╠═38d308da-02cb-48c3-9b3f-fe0dc0d99008
# ╟─5e49b23b-4776-4f77-b297-73e933d930f1
# ╠═bf51eb42-52ec-43a2-adaa-7e92d215aa85
# ╠═7c9f0697-a081-41f0-93b8-45fab58ac4ee
# ╠═fea4e364-a698-4804-81f1-5ddfd27461c4
# ╠═a1e6f79b-a7dc-48f1-8d7f-1d8f9488fe3e
# ╠═0abc8aeb-3cc7-4757-87c1-d285591cd06b
# ╠═ad52e463-89ad-4caf-a5bf-b7c6cbd69119
# ╠═162d041c-9318-436f-9cf2-4620cd84f067
# ╠═d88f94ce-138f-4441-ac30-3b65d02ceae6
# ╠═e29d8abd-cce0-4e98-9652-0d4448f310e1
# ╠═539e7892-ce27-4c72-815a-e75240b27777
# ╟─f061ef71-7e73-4bb5-a109-4f864435eb9c
# ╠═a8e83f10-4665-42e0-9852-ca66186b46a3
# ╟─544903a0-bd8f-43c0-a602-fd87ced610ea
# ╠═e44ca0b3-f8b2-4c26-849b-759b7bd9fc83
# ╟─94d57ac7-37db-4036-a2d0-1440df97cb6d
# ╠═15f9d484-62bd-404f-8ebe-52300742a674
# ╠═06a3fd80-422d-4917-9c28-555eb37f1862
# ╠═a76dfcd0-7ad6-4232-9022-ba355d69565b
# ╟─bd986b69-6b61-4191-a98a-8b9dedfa1abd
# ╠═429a8b0e-7b28-439f-bf84-231545219336
# ╟─90115b83-057c-4457-a2a9-584252606976
# ╟─f5762ff1-f0da-46a2-9dc9-b470c80bb919
# ╟─293d7aae-02e8-49a2-acdb-b57aed59dcbe

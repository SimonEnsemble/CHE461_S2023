### A Pluto.jl notebook ###
# v0.19.25

using Markdown
using InteractiveUtils

# ╔═╡ c9b7b9d2-cc91-11ec-3145-9b557b81a06a
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie, Polynomials
end

# ╔═╡ 71bde5ab-f2b8-4c9f-aea1-ba298be87db2
set_theme!(Controlz.cool_theme)

# ╔═╡ f3740f48-2c10-4f3b-9886-33a04279f989
md"## on the stability of closed-loop control systems

!!! note \"the idea 💡\"
	we've empirically observed that large I-action leads to \"inertia\", where the integral of the error builds up, and it takes a while to diminish even after the controlled variable finally reaches it set point, leading to oscillations. this studio is to explore more rigorously how large I-action can lead to instability.

📖 if the closed-loop is _unstable_, we expect the controlled variable $y(t)$ to grow unboundedly after we make a set point change.

below is the closed-loop control system---the focus of this studio---composed of:
* a first-order process
* a sensor with first-order dynamics
* a PI controller
  * the gain is set $K_c=1$ because this worked well for P-control.
  * the integral time constant $\tau_I$ is to be determined. we will explore different values in this studio.
![](https://raw.githubusercontent.com/SimonEnsemble/CHE461_S2022/main/random/stability_closed_loop.png)
"

# ╔═╡ 02873045-8df2-4099-9325-e7ec0654d549
md"🍩 assign the process and sensor transfer functions as variables `G_u` and `G_s` below."

# ╔═╡ cab49729-5b76-4e9b-86c2-a2ba15e81c6c

# ╔═╡ 5fae1407-aca3-434a-aab5-39a30e6019d0

# ╔═╡ 3ffc25d5-0fc0-487d-8e2f-c619a7ca3f7a
md"🍩 for now, let's take $\tau_I=3$. in that case, assign the controller transfer function as a variable `G_c` below."

# ╔═╡ 9961c3d1-7192-4c88-a863-f94572b3ef56
begin
	# PI-controller params
	K_c = 1.0
	τ_I = 3.0
end

# ╔═╡ 39e4c7bc-ef6c-4be1-9a40-2b59def350ef

# ╔═╡ 6c79a25d-7ae8-46fc-8504-e4b3ae48a1f9
md"🍩 assign the open-loop transfer function as a variable `G_ol` below.

!!! hint
    allow `Controlz.jl` to do the algebra for you!
"

# ╔═╡ 3c68c65d-4be6-4d41-98d6-62bc220e75df

# ╔═╡ 78732491-1e3f-4fed-9cb2-87ec9694bfc3
md"🍩 assign the closed-loop transfer function governing the closed-loop response of the controlled variable $y^*$ to set point changes $y_{sp}^*$ as a variable `G_servo`.

!!! hint
	use `G_ol` you defined above!
"

# ╔═╡ df1ac88d-7dae-45fa-8700-61d90dd9980c

# ╔═╡ 2768815d-4f66-4441-ad40-d92cbc681d66
md"🍩 determine the characteristic equation of the closed loop system in the form of a polynomial.
* ✏ first, derive it on pencil and paper.
* 💻 second, use `characteristic_polynomial` (see [here](https://simonensemble.github.io/Controlz.jl/dev/tfs/#Controlz.characteristic_polynomial)) to obtain it.
!!! note
	the roots of the characteristic equation determine the stability of the closed-loop response to set point changes. specifically, the closed-loop is stable iff _all_ of its roots lie in the LHP.
"

# ╔═╡ aa223640-bee7-470d-9057-c0993db46ec9

# ╔═╡ 01b76948-5e8a-4440-8fcd-a5b03df4392b
md"🍩 compute the roots of the characteristic equation using the `roots` function (see [here](http://juliamath.github.io/Polynomials.jl/stable/#Root-finding)).
* is the closed-loop response stable to set point changes?

[...your answer here...]

* do you expect the closed-loop response (to a set point change) to exhibit oscillations?

[...your answer here...]

"

# ╔═╡ c0d20bc3-9a49-40a4-ab5e-fde9db279d78

# ╔═╡ 1c8ea2f5-8094-4723-862a-f52a4e36d655
md"
!!! note
    the roots of the characteristic equation are poles of the closed-loop transfer function.

🍩 use `viz_poles_and_zeros` (see [here](https://simonensemble.github.io/Controlz.jl/dev/viz/#poles-and-zeros-of-a-transfer-function)) to visualize the poles and zeros of the closed-loop transfer function `G_servo` to confirm.

"

# ╔═╡ 76977dce-698c-409f-a2a8-b3953ff4a6a3

# ╔═╡ 9fa6727b-6e59-4c2e-a72b-51358fe2443f
md"🍩 finally, simulate the closed-loop response to a unit set point change (with this choice of $\tau_I$).
* construct `Ysp★`
* construct `Y★`
* use `simulate` to simulate for $t\in[0, 10]$
* visualize the response e.g. via `viz_response`

e.g. see [docs](https://simonensemble.github.io/Controlz.jl/dev/viz/#response-of-a-system-to-an-input).

🍩 does the response confirm your predictions of (i) stability and (ii) presence/absence of oscillations?

[...your answer here...]
"

# ╔═╡ f2652e2b-9fc7-44ca-bcc1-75f41b758b92

# ╔═╡ 935f1e2b-0057-4d49-9808-a25577acad13

# ╔═╡ b7027242-471b-4df4-a153-8f63c7c2adcb

# ╔═╡ 40297150-ed78-4631-915b-cc00381ebee2

# ╔═╡ 6bb5466f-d406-4fbf-a3ae-5f99b7fec505
md"🍩 now assess how different choices of $\tau_I$ affect the stability of the closed-loop response by changing `τ_I` above. fill out the table below with your observations.

!!! hint
	click the \"eye\" in the top left corner to edit the text in this cell.

| integral time constant $\tau_I$    | I-action level | stability of closed-loop response according to roots of $1+G_{OL}(s)=0$  | stability of closed-loop response according to simulation | 
| ----------- | ----------- | ----------- | ----------- |
| 3.0  |    lowest   |  |  |
| 1.0  |    low   |  |  |
| 1/2     |     high   |  |  |
| 1/3      |  highest   |  | |

"

# ╔═╡ d36551c8-f066-408a-b970-c10682aba507
md"🍩 what do you conclude about the influence of I-action on the stability of a closed-loop control system?

[...your answer here...]
"

# ╔═╡ 767f169c-2ee0-4326-ac63-d149bb785093
md"
!!! warning
	before you turn in this studio, set $\tau_i$ to be 3.0 as in the beginning of this assignment. this will facilitate our scoring of your studio. 🙇
"

# ╔═╡ Cell order:
# ╠═c9b7b9d2-cc91-11ec-3145-9b557b81a06a
# ╠═71bde5ab-f2b8-4c9f-aea1-ba298be87db2
# ╟─f3740f48-2c10-4f3b-9886-33a04279f989
# ╟─02873045-8df2-4099-9325-e7ec0654d549
# ╠═cab49729-5b76-4e9b-86c2-a2ba15e81c6c
# ╠═5fae1407-aca3-434a-aab5-39a30e6019d0
# ╟─3ffc25d5-0fc0-487d-8e2f-c619a7ca3f7a
# ╠═9961c3d1-7192-4c88-a863-f94572b3ef56
# ╠═39e4c7bc-ef6c-4be1-9a40-2b59def350ef
# ╟─6c79a25d-7ae8-46fc-8504-e4b3ae48a1f9
# ╠═3c68c65d-4be6-4d41-98d6-62bc220e75df
# ╟─78732491-1e3f-4fed-9cb2-87ec9694bfc3
# ╠═df1ac88d-7dae-45fa-8700-61d90dd9980c
# ╟─2768815d-4f66-4441-ad40-d92cbc681d66
# ╠═aa223640-bee7-470d-9057-c0993db46ec9
# ╟─01b76948-5e8a-4440-8fcd-a5b03df4392b
# ╠═c0d20bc3-9a49-40a4-ab5e-fde9db279d78
# ╟─1c8ea2f5-8094-4723-862a-f52a4e36d655
# ╠═76977dce-698c-409f-a2a8-b3953ff4a6a3
# ╟─9fa6727b-6e59-4c2e-a72b-51358fe2443f
# ╠═f2652e2b-9fc7-44ca-bcc1-75f41b758b92
# ╠═935f1e2b-0057-4d49-9808-a25577acad13
# ╠═b7027242-471b-4df4-a153-8f63c7c2adcb
# ╠═40297150-ed78-4631-915b-cc00381ebee2
# ╟─6bb5466f-d406-4fbf-a3ae-5f99b7fec505
# ╟─d36551c8-f066-408a-b970-c10682aba507
# ╟─767f169c-2ee0-4326-ac63-d149bb785093

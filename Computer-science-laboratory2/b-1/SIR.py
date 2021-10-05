import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as plt

# S = 0 I = 1, R = 2


def SIReq(SIR, t, gamma, beta):
    dS = -gamma*SIR[0]*SIR[1]
    dI = (gamma/N)*SIR[1]*SIR[0] - beta*SIR[1]
    dR = gamma*SIR[1]

    return [dS, dI, dR]


t = np.linspace(0, 30, 1000)  # time
beta = 1
gamma = 0.2  # parameters

initvar = [0.9, 0.1, 0]  # [S(0), I(0), R(0)]
SIRlist = odeint(SIReq, initvar, t, args=(beta, gamma))

fig, ax = plt.subplots()
ax.set_xlabel('time')
ax.set_ylabel('population')
ax.set_title(r'Time evolution of $(S(t), I(t), R(t))$')
ax.grid()
ax.plot(t, SIRlist[:, 0], linestyle="solid", label="S", color="black")
ax.plot(t, SIRlist[:, 1], linestyle="dotted", label="I", color="black")
ax.plot(t, SIRlist[:, 2], linestyle="dashed", label="R", color="black")
ax.legend(loc=0)
fig.tight_layout()
plt.show()

print('R0 =', beta/gamma)

import sys
import numpy as np
import torch as T
from AI import Agent, DQN

gamma = .99
epsilon = 1
learning_rate = .001
nA = 4
e_decrament = .0001
e_end = .001
iDIM = [4]



agent = Agent(G = gamma, E = epsilon, LRate= learning_rate, IDimensions= iDIM, BSize= 64, n_actions=nA)

def reward(oldD, newD):
    old_p = oldD
    new_p = newD
    dChange = np.linalg.norm(np.array(new_p) - np.array(old_p))

    if dChange > 0:
        return 1
    else:
        return -1



def Action(state):
    action = agent.choose(state)
    return action

def get_state():
    if len(sys.argv) > 1:
        state_str = sys.argv[1]
        state = eval(state_str)
        return state
    else:
        print("State not passed. Exiting.")
        sys.exit(1)

def perform_action(action):
    fPath = r"C:\\Users\\Juneb\\Documents\\GitHub\\knighthacks25\\PythonScripts\\action.txt"
    try:
        with open(fPath, "w") as file:
            file.write(str(action))  # Writing the action as a string
        print(f"Action {action} written to {fPath}")
    except Exception as e:
        print(f"Error writing to file: {e}")

def gameover(alive):
    return alive
    
def loop():
    state = get_state()
    oldD = state[0]
    max = 500
    count = 0
    while count < max:
        action = Action(state)
        perform_action(action)
        next_state = get_state()
        newD = next_state[0]
        reward = reward(oldD, newD)
        d = gameover()

        agent.store_transition(state, action, reward, next_state, 0)

        agent.learn()

        state = next_state
        oldD = newD

        
        count += 1
if __name__ == "__main__":
    loop() 

        



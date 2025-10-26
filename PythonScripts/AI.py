import torch as T
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import numpy as np

class DQN(nn.Module):
    def _init_(self,LRate, IDimensions, F1Dimensions, F2Dimensions, n_actions):
        super(DQN,self).__init__()
        self.IDimensions = IDimensions
        self.F1Dimensions = F1Dimensions
        self.f2Dimensions = F2Dimensions
        self.n_actions = n_actions
        self.F1Dimensions = nn.Linear(*self.IDimensions, self.F1Dimensions)
        self.f2Dimensions = nn.Linear(self.F1Dimensions, self.F2Dimensions)
        self.F3Dimensions = nn.Linear(self.f2Dimensions, self.n_actions)
        self.optimizer = optim.Adam(self.parameters(), LRate = LRate)
        self.loss = nn.MSELoss()
        self.device = T.device('cuda:0' if T.cuda.is_available() else 'cpu')
        self.to(self.device)

        def forward(self, state):
            x = F.relu(self.F1Dimensions(state))
            x = F.relu(self.F2Dimensions(x))
            actions = self.F3Dimensions(x)

            return actions
        

    class Agent():
        def _init_(self, G, E, LRate, IDimensions, BSize, n_actions,
                   MaxSize = 100000, e_end = .01, e_dec = 5e-4): 
            self.G = G
            self.E = E
            self.e_min = e_end
            self.e_dec = e_dec
            self.LRate = LRate
            self.ASpace = [i for i in range(n_actions)]
            self.MSize = MaxSize
            self.BSize = BSize
            self.MCount = 0

            self.Q_eval = DQN(self.Lrate, n_actions = n_actions, IDimensions = IDimensions, F1Dimensions = 256, F2Dimensions = 256)

            self.s_memory = np.zeros((self.MSize, *IDimensions), dtype=np.float32)
            self.ns_memory = np.zeros((self.MSize, *IDimensions), dtype=np.float32)

            self.a_memory = np.zeros(self.Msize, dtype=np.int32)
            self.r_memory = np.zeros(self.MSize, dtype= np.float32)
            self.t_memory = np.zeros(self.MSize, dtype=np.bool)

            def store_transition(self, state, action, reward, n_state, done):
                index = self.MCount % self.MSize
                self.s_memory[index] = state 
                self.ns_memory[index] = n_state
                self.r_memory[index] = reward
                self.a_memory[index] = action
                self.t_memory[index] = done
                self.MCount += 1

            def choose(self,observation):
                action = np.random.choice(self.ASpace)

                if np.random.random() > self.E:
                    state = T.tensor([observation]).to(self.Q_eval.device)
                    actions = self.Q_eval.forward(state)
                    action = T.argmax(actions)
                
                return action
            
            def learn(self):
                if self.MCount < self.BSize:
                    return
                self.Q_eval.optimizer.zero_grad()

                MaxSize = min(self.MCount, self.MSize)
                batch = np.random.choice(MaxSize, self.BSize, replace = False)
                BIndex = np.arange(self.BSize, dtype= np.int32)

                SBatch = T.tensor(self.s_memory[batch]).to(self.Q_eval.device)
                NSBatch = T.tensor(self.ns_memory[batch]).to(self.Q_eval.device)
                RBatch = T.tensor(self.r_memory[batch]).to(self.Q_eval.device)
                TBatch = T.tensor(self.t_memory[batch]).to(self.Q_eval.device)
                ABatch = self.a_memory[batch]

                q_eval = self.Q_eval.forward(SBatch)[BIndex, ABatch]
                q_next = self.Q_eval.forward(NSBatch)
                q_next[TBatch] = 0.0
                q_target = RBatch + self.G * T.max(q_next, dim=1)[0]

                loss = self.Q_eval.loss(q_target, q_eval).to(self.Q_eval.device)
                loss.backward()
                self.Q_eval.optimizer.step()

                self.E = self.E - self.e_dec if self.E > self.e_min \
                else self.e_min

                

                    
                    



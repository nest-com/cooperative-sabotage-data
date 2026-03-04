This dataset consists of the MaDIoT+Industroyer attack simulation results on the PST-16 benchmark power system (using PowerFactory) that are analysed and presented in the following paper that is currently under review in a scientific journal: 

"Cooperative Sabotage: The Synergistic Threat of Industroyer and MaDIoT in a Power System"
Authors: Nestor Rodriguez-Perez, Juan Lozano, Lukas Sigrist, Gregorio Lopez, Álvaro Cardenas


The files are in CSV format and represent raw results to be processed. 


Those files whose filename starts with 'resultData\_' summarise the results for the simulations executed for the scenario included in the filename. For example, file 'resultData\_onlyIndustroyer' presents the summary of results of the simulations executed when only Industroyer actuates. File 'resultData\_onlyMaDIoT' presents the summary of results of the simulations executed when only MaDIoT actuates (600 MW and 1050MW of demand), but Industroyer is not active. File 'resultData\_AllCases' presents the summary of results of the simulations executed when Industroyer and MaDIoT perform combined attacks. File 'resultData\_Industroyer\_MaDIoT\_interconnectionLines' presents the summary of results of the simulations executed when Industroyer and MaDIoT perform combined attacks, but only interconnection lines are considered by Industroyer. 

Inside the 'resultData\_' files, the columns are the following: 
* filename: This just indicates which loads (MaDIoT) (i.e., nodes where they are connected), and which Lines (Industroyer)were compromised in the simulation run.
* numNodes: Number of demand nodes that are compromised in the MaDIoT attack to increase their load
* area: Area of the PST-16 system where the demand are compromised  by MaDIoT and where Industroyer actuates (in all cases, area C of PST-16)
* compromisedMW: Amount of active power that is increased due to the MaDIoT attack
* compromisedMvar: Amount of reactive power that is increased due to the MaDIoT attack
* meanDelay: Mean delay for the execution of the load increase (0 in all the simulations)
* stdDelay: Standard deviation of the delay for the execution of the load increase (0 in all the simulations)
* initialTotalDemand: Demand of the PST-16 power system at the beginning of the simulation (without the attack)
* finalTotalDemand: Demand of the PST-16 power system at the end of the simulation
* finalDemandPercentage: Demand of the PST-16 power system at the end of the simulation with respect to the initial demand, in %
* generationCapacityTripped: MWs of generators disconnected due to the activation of OFGR protections
* loadsShed: MWs of load disconnected due to the activation of UFLS protections
* overVoltageLoads: MWs of load disconnected due to the activation of overvoltage protections
* underVoltageLoads: MWs of load disconnected due to the activation of undervoltage protections
* compromisedPV: MWs of DER (solar PV) disconnected. In all cases, this is 0, as it was not part of the study.       


As the 'resultData\_' files constitute raw results from simulations, be aware that some cases may be repeated. You can eliminate duplicates using the 'filename' columns. 


Folder RMS includes the results from RMS simulations. That is, the files included in this folder are the data ploted in the figure exploring the dynamics of just MaDIoT attack; just Industroyer; and MaDIoT+Industroyer.The CSVs include the time series data of different variables recorded by PowerFactory (RMS simulation). Variables are:
* time
* u\_\[node]: Voltage at \[node]
* f\_\[node]: Frequency at \[node]
* relAngle\_\[node]: Relative rotor angle of the generator connected to  \[node]

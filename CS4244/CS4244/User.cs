using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SQLite;

namespace CS4244
{
    class User
    {
        private string _name;
        private string _cohort;
        private string _minMax;
        private string _fyp;
        private string _focusArea;
        private string _projectType;
        private string _jcPoly;

        private List<string> _core = new List<string>();
        private List<string> _focusAreas = new List<string>();
        private List<string> _gem = new List<string>();
        private List<string> _breadth = new List<string>();
        private List<string> _ue = new List<string>();
        private List<string> _scienceMods = new List<string>();
        private List<string> _ss = new List<string>();
        private List<string> _others = new List<string>();

        private List<string> _personalPreference = new List<string>();
        private List<string> _moduleLike = new List<string>();
        private List<string> _moduleDislike = new List<string>();

        private List<string> _moduleLikeInstance = new List<string>();
        private List<string> _moduleDislikeInstance = new List<string>();
        private List<string> _moduleTagInstance = new List<string>();
        private List<string> _focusAreaInstance = new List<string>();
        private List<string> _modulesTakenInstance = new List<string>();
        private List<string> _requirementInstance = new List<string>();
        private List<string> _requiredModulesInstance = new List<string>();
        List<List<string>> AllTheList = new List<List<string>>();

        public User()
        {
            AllTheList.Add(_moduleLikeInstance);
            AllTheList.Add(_moduleDislikeInstance);
            AllTheList.Add(_moduleTagInstance);
            AllTheList.Add(_focusAreaInstance);
            AllTheList.Add(_modulesTakenInstance);
            AllTheList.Add(_requirementInstance);
            AllTheList.Add(_requiredModulesInstance);
        }

        public void OutputEverything()
        {
            foreach (List<string> element in AllTheList)
            {
                foreach (string output in element)
                {
                    Console.WriteLine(output);
                }
            }
        }

        public void setName(string name)
        {
            _name = name;
        }

        public string getName()
        {
            return _name; 
        }

        public void setCohort(string cohort)
        {
            _cohort = cohort;
        }

        public string getCohort()
        {
            return _cohort;
        }

        public void setMinMax(string minMax)
        {
            _minMax = minMax;
        }

        public string getMinMax()
        {
            return _minMax;
        }

        public void setFYP(string fyp)
        {
            _fyp = fyp;
        }

        public string getFYP()
        {
            return _fyp;
        }

        public void setFocusArea(string focusArea)
        {
            _focusArea = focusArea;
        }

        public string getFocusArea()
        {
            return _focusArea;
        }

        public void setProjectType(string projectType)
        {
            _projectType = projectType;
        }

        public string getProjectType()
        {
            return _projectType;
        }

        public void setJCPoly(string jcPoly)
        {
            _jcPoly = jcPoly;
        }

        public string getJCPoly()
        {
            return _jcPoly;
        }

        public void setCore(string core)
        {
            _core.Add(core);
        }

        public List<string> getCore()
        {
            return _core;
        }

        public void setFocusAreas(string focusAreas)
        {
            _focusAreas.Add(focusAreas);
        }

        public List<string> getFocusAreas()
        {
            return _focusAreas;
        }

        public void setGem(string gem)
        {
            _gem.Add(gem);
        }

        public List<string> getGem()
        {
            return _gem;
        }

        public void setBreadth(string breadth)
        {
            _breadth.Add(breadth);
        }

        public List<string> getBreadth()
        {
            return _breadth;
        }

        public void setUe(string ue)
        {
            _ue.Add(ue);
        }

        public List<string> getUe()
        {
            return _ue;
        }

        public void setScienceMods(string scienceMods)
        {
            _scienceMods.Add(scienceMods);
        }

        public List<string> getScienceMods()
        {
            return _scienceMods;
        }

        public void setSS(string ssMods)
        {
            _ss.Add(ssMods);
        }

        public List<string> getSS()
        {
            return _ss;
        }

        public void setOthers(string others)
        {
            _others.Add(others);
        }

        public List<string> getOthers()
        {
            return _others;
        }

        public void setPersonalPref(string personalPref)
        {
            _personalPreference.Add(personalPref);
        }

        public List<string> getPersonalPref()
        {
            return _personalPreference;
        }

        public void setModulesLike(string moduleLike)
        {
            _moduleLike.Add(moduleLike);
        }

        public List<string> getModulesLike()
        {
            return _moduleLike;
        }

        public void setModuleDislike(string moduleDislike)
        {
            _moduleDislike.Add(moduleDislike);
        }

        public List<string> getModuleDislike()
        {
            return _moduleDislike;
        }

        public void createInterestModuleInstance()
        {
            List<string> moduleLike = new List<string>();

            moduleLike = _moduleLike;

            for (int i = 0; i < moduleLike.Count; i++)
            {
                string[] temp = moduleLike[i].Split(' ');
                _moduleLikeInstance.Add("(make-instance [Interest" + temp[0].Trim() + "] of INTERESTEDMODULE (moduleid " + temp[0].Trim() + "))");
            }
        }

        public List<string> getInterestModuleInstance()
        {
            return _moduleLikeInstance;
        }

        public void createDisInterestModuleInstance()
        {
            List<string> moduleDislike = new List<string>();

            moduleDislike = _moduleDislike;

            for (int i = 0; i < moduleDislike.Count; i++)
            {
                string[] temp = moduleDislike[i].Split(' ');
                _moduleDislikeInstance.Add("(make-instance [DisInterest" + temp[0].Trim() + "] of NOTINTERESTEDMODULE (moduleid " + temp[0].Trim() + "))");
            }
        }

        public List<string> getDisInterestModuleInstance()
        {
            return _moduleDislikeInstance;
        }

        public void createInterestTagInstance()
        {
            List<string> moduleTag = new List<string>();

            moduleTag = _personalPreference;

            for (int i = 0; i < moduleTag.Count; i++)
            {
                _moduleTagInstance.Add("(make-instance [Tag" + moduleTag[i].Trim() + "] of INTERESTEDTAG (tag " + moduleTag[i].Trim() + "))");
            }
        }

        public List<string> getInterestTagInstance()
        {
            return _moduleTagInstance;
        }
        
        public void createFocusAreaInstance()
        {
            List<string> focusArea = new List<string>();
            string primary = "";
            string elective = "";
            
            string fArea = _focusArea;
            focusArea = _focusAreas;

            string dbConnectionString = @"Data Source=C:\Users\User\Documents\Visual Studio 2010\Projects\CS4244\CS4244\CS4244.sqlite;Version=3;";
            SQLiteConnection con = new SQLiteConnection(dbConnectionString);

            try
            {
                con.Open();
                string query = "Select [Primary], Elective from FocusArea where FocusArea = '" + fArea + "'";
                SQLiteCommand command = new SQLiteCommand(query, con);
                SQLiteDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    primary = (reader.GetString(0));
                    elective = (reader.GetString(1));
                }
                con.Close();
            }
            catch (Exception ex)
            {
                Console.Write(ex);
            }

            string[] primarys = primary.Split(',');
            string[] electives = elective.Split(',');

            for (int i = 0; i < primarys.Count(); i++)
            {
                _focusAreaInstance.Add("(make-instance [FocusArea" + primarys[i].Trim() + "] of FOCUSAREA (moduleid " + primarys[i].Trim() + ") (type PRIMARY))");
            }

            for (int i = 0; i < electives.Count(); i++)
            {
                _focusAreaInstance.Add("(make-instance [FocusArea" + electives[i].Trim() + "] of FOCUSAREA (moduleid " + electives[i].Trim() + ") (type ELECTIVE))");
            }
        }

        public List<string> getFocusAreaInstance()
        {
            return _focusAreaInstance;
        }
        // To Do, add focus areas
        public void createModulesTakenInstance()
        {
            List<string> modulesTaken = new List<string>();

            // Add Core
            if (_core.Count != 0)
            {
                for (int i = 0; i < _core.Count(); i++)
                {
                    modulesTaken.Add(_core[i]);
                }
            }
            // Add GEM
            if (_gem.Count != 0)
            {
                for (int i = 0; i < _gem.Count(); i++)
                {
                    modulesTaken.Add(_gem[i]);
                }
            }
            // Add SS
            if (_ss.Count != 0)
            {
                for (int i = 0; i < _ss.Count(); i++)
                {
                    modulesTaken.Add(_ss[i]);
                }
            }
            // Add Breadth
            if (_breadth.Count != 0)
            {
                for (int i = 0; i < _breadth.Count(); i++)
                {
                    modulesTaken.Add(_breadth[i]);
                }
            }
            // Add UE
            if (_ue.Count != 0)
            {
                for (int i = 0; i < _ue.Count(); i++)
                {
                    modulesTaken.Add(_ue[i]);
                }
            }
            // Add Science Mods
            if (_scienceMods.Count != 0)
            {
                for (int i = 0; i < _scienceMods.Count(); i++)
                {
                    modulesTaken.Add(_scienceMods[i]);
                }
            }
            
            for (int i = 0; i < modulesTaken.Count; i++)
            {
                string[] temp = modulesTaken[i].Split(' ');
                _modulesTakenInstance.Add("(make-instance [allmodule" + temp[0].Trim() + "] of MODULETAKEN (moduleid " + temp[0].Trim() + "))");
            }

            // Add Focus Area
            if (_focusAreas.Count != 0)
            {
                for (int i = 0; i < _focusAreas.Count(); i++)
                {
                    _modulesTakenInstance.Add("(make-instance [allmodule" + _focusAreas[i].Trim() + "] of MODULETAKEN (moduleid " + _focusAreas[i].Trim() + "))");
                }
            }
        }

        public List<string> getModulesTakenInstance()
        {
            return _modulesTakenInstance;
        }

        public void createRequirementInstance()
        {
            string ueMC = "20";
            string gemMC = "8";
            string ssMC = "4";
            string breadthMC = "8";
            string focusAreaMC = "";
            string focusAreaLevel4 = "";
            int count = 0;

            // Handle JC exemptions
            if (_jcPoly.Equals("JC"))
            {
                if (_ue.Count != 0)
                {
                    if (!_ue[0].Equals(""))
                    {
                        ueMC = (20 - _ue.Count() * 4).ToString();
                    }
                }

                if (_gem.Count != 0)
                {
                    if (!_gem[0].Equals(""))
                    {
                        gemMC = (8 - _gem.Count() * 4).ToString();
                    }   
                }
                
                if (_ss.Count != 0)
                {
                    if (!_ss[0].Equals(""))
                    {
                        ssMC = (4 - _ss.Count() * 4).ToString();
                    }
                }

                if (_breadth.Count != 0)
                {
                    if (!_breadth[0].Equals(""))
                    {
                        breadthMC = (8 - _breadth.Count() * 4).ToString();
                    }
                }
            }
            else if (_jcPoly.Equals("Poly")) // Handle Poly exemptions
            {
                ueMC = "8";
                gemMC = "4";
                ssMC = "4";
                breadthMC = "4";

                if (_ue.Count != 0)
                {
                    if (!_ue[0].Equals(""))
                    {
                        ueMC = (8 - _ue.Count() * 4).ToString();
                    }
                }

                if (_gem.Count != 0)
                {
                    if (!_gem[0].Equals(""))
                    {
                        gemMC = (4 - _gem.Count() * 4).ToString();
                    }
                }

                if (_ss.Count != 0)
                {
                    if (!_ss[0].Equals(""))
                    {
                        ssMC = (4 - _ss.Count() * 4).ToString();
                    }
                }

                if (_breadth.Count != 0)
                {
                    if (!_breadth[0].Equals(""))
                    {
                        breadthMC = (4 - _breadth.Count() * 4).ToString();
                    }
                }
            }
            
            // FocusAreaMC Calculation
            focusAreaMC = (24 - _focusAreas.Count() * 4).ToString();
            // FocusAreaLevel4 Calculation
            for (int i = 0; i < _focusAreas.Count(); i++)
            {
                if (_focusAreas[i].ElementAt(2).Equals('4') || _focusAreas[i].ElementAt(2).Equals('5') || _focusAreas[i].ElementAt(2).Equals('6'))
                {
                    count++;
                }
            }

            focusAreaLevel4 = (3 - count).ToString();

            _requirementInstance.Add("(make-instance [REQUIREMENT] of REQUIREMENT (UE " + ueMC + ")(GEM " + gemMC + ")(SS " + ssMC + ")(breadth " + breadthMC + ")(focusareamc " + focusAreaMC + ")(focusarealevel4 " + focusAreaLevel4 + "))");
        }

        public List<string> getRequirementInstance()
        {
            return _requirementInstance;
        }

        public void createRequiredModulesInstance()
        {
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS1010] of REQUIREDCOREMODULE (moduleid CS1010))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS1020] of REQUIREDCOREMODULE (moduleid CS1020))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS2010] of REQUIREDCOREMODULE (moduleid CS2010))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS1231] of REQUIREDCOREMODULE (moduleid CS1231))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS2100] of REQUIREDCOREMODULE (moduleid CS2100))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS2103T] of REQUIREDCOREMODULE (moduleid CS2103T))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS2105] of REQUIREDCOREMODULE (moduleid CS2105))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS2106] of REQUIREDCOREMODULE (moduleid CS2106))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS3230] of REQUIREDCOREMODULE (moduleid CS3230))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleIS1103] of REQUIREDCOREMODULE (moduleid IS1103))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleCS2101] of REQUIREDCOREMODULE (moduleid CS2101))");
            // should have rules to take care of MA1301 in clips for JC students
            _requiredModulesInstance.Add("(make-instance [RequiredModuleMA1301] of REQUIREDCOREMODULE (moduleid MA1301))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleMA1521] of REQUIREDCOREMODULE (moduleid MA1521))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleMA1101R] of REQUIREDCOREMODULE (moduleid MA1101R))");
            _requiredModulesInstance.Add("(make-instance [RequiredModuleST2334] of REQUIREDCOREMODULE (moduleid ST2334))");
            _requiredModulesInstance.Add("(make-instance [RequiredModulePC1222] of REQUIREDCOREMODULE (moduleid PC1222))");

            if (_fyp.Equals("Yes"))
            {
                _requiredModulesInstance.Add("(make-instance [RequiredModuleCP4101] of REQUIREDCOREMODULE (moduleid CP4101))");
            }

            if (_projectType.Contains("CS3201"))
            {
                _requiredModulesInstance.Add("(make-instance [RequiredModuleCS3201] of REQUIREDCOREMODULE (moduleid CS3201))");
                _requiredModulesInstance.Add("(make-instance [RequiredModuleCS3202] of REQUIREDCOREMODULE (moduleid CS3202))");
            }
            else if (_projectType.Contains("CS3281"))
            {
                _requiredModulesInstance.Add("(make-instance [RequiredModuleCS3281] of REQUIREDCOREMODULE (moduleid CS3281))");
                _requiredModulesInstance.Add("(make-instance [RequiredModuleCS3282] of REQUIREDCOREMODULE (moduleid CS3282))");
            }
            else
            {
                _requiredModulesInstance.Add("(make-instance [RequiredModuleCS3283] of REQUIREDCOREMODULE (moduleid CS3283))");
                _requiredModulesInstance.Add("(make-instance [RequiredModuleCS3284] of REQUIREDCOREMODULE (moduleid CS3284))");
            }
        }

        public List<string> getRequiredModulesInstance()
        {
            return _requiredModulesInstance;
        }

        public List<List<string>> getAllInstances()
        {
            return AllTheList;
        }
    }
}

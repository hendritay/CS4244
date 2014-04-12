using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

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

        private List<string> _personalPreference = new List<string>();
        private List<string> _moduleLike = new List<string>();
        private List<string> _moduleDislike = new List<string>();

        private List<string> _moduleLikeInstance = new List<string>();
        private List<string> _moduleDislikeInstance = new List<string>();
        private List<string> _moduleTagInstance = new List<string>();
        private List<string> _focusAreaInstance = new List<string>();

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
            List<string> createInstance = new List<string>();
            List<string> moduleLike = new List<string>();

            moduleLike = _moduleLike;

            for (int i = 0; i < moduleLike.Count; i++)
            {
                string[] temp = moduleLike[i].Split(' ');
                createInstance.Add("(make-instance [Interest " + temp[0].Trim() + "] of INTERESTEDMODULE (moduleid "+ temp[0].Trim() + "))");
            }

            _moduleLikeInstance = createInstance;
        }

        public List<string> getInterestModuleInstance()
        {
            return _moduleLikeInstance;
        }

        public void createDisInterestModuleInstance()
        {
            List<string> createInstance = new List<string>();
            List<string> moduleDislike = new List<string>();

            moduleDislike = _moduleDislike;

            for (int i = 0; i < moduleDislike.Count; i++)
            {
                string[] temp = moduleDislike[i].Split(' ');
                createInstance.Add("(make-instance [DisInterest " + temp[0].Trim() + "] of NOTINTERESTEDMODULE (moduleid " + temp[0].Trim() + "))");
            }

            _moduleDislikeInstance = createInstance;
        }

        public List<string> getDisInterestModuleInstance()
        {
            return _moduleDislikeInstance;
        }

        public void createInterestTagInstance()
        {
            List<string> createInstance = new List<string>();
            List<string> moduleTag = new List<string>();

            moduleTag = _personalPreference;

            for (int i = 0; i < moduleTag.Count; i++)
            {
                createInstance.Add("(make-instance [Tag " + moduleTag[i].Trim() + "] of INTERESTEDTAG (tag " + moduleTag[i].Trim() + "))");
            }

            _moduleTagInstance = createInstance;
        }

        public List<string> getInterestTagInstance()
        {
            return _moduleTagInstance;
        }

        public void createFocusAreaInstance()
        {
            List<string> createInstance = new List<string>();
            List<string> focusArea = new List<string>();

            focusArea = _focusAreas;

            for (int i = 0; i < focusArea.Count; i++)
            {
                createInstance.Add("(make-instance [FocusArea " + focusArea[i].Trim() + "] of FOCUSAREA (moduleid " + focusArea[i].Trim() + ") (type SECONDARY))");
            }

            _focusAreaInstance = createInstance;
        }

        public List<string> getFocusAreaInstance()
        {
            return _focusAreaInstance;
        }
    }
}

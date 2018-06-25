package ddt.manager
{
   import ddt.data.analyze.FineSuitAnalyze;
   import ddt.data.store.FineSuitVo;
   import road7th.data.DictionaryData;
   
   public class FineSuitManager
   {
      
      private static var _instance:FineSuitManager;
       
      
      private var _model:DictionaryData;
      
      private var _materialIDList:Array;
      
      private var _data:DictionaryData;
      
      private var propertyList:Array;
      
      private var nameList:Array;
      
      public function FineSuitManager()
      {
         propertyList = ["hp","Defence","Luck","Agility","MagicDefence","Armor"];
         nameList = LanguageMgr.GetTranslation("storeFine.effect.contentText").split(",");
         super();
      }
      
      public static function get Instance() : FineSuitManager
      {
         if(_instance == null)
         {
            _instance = new FineSuitManager();
         }
         return _instance;
      }
      
      public function setup(analyze:FineSuitAnalyze) : void
      {
         _model = analyze.list;
         _materialIDList = analyze.materialIDList;
         _data = analyze.tipsData;
      }
      
      public function getSuitVoByExp(exp:int) : FineSuitVo
      {
         var i:int = 0;
         var vo:* = null;
         for(i = 0; i < _model.length; )
         {
            vo = _model[i.toString()] as FineSuitVo;
            if(exp < vo.exp)
            {
               vo = _model[(i - 1).toString()] as FineSuitVo;
               return vo;
            }
            i++;
         }
         return vo;
      }
      
      public function getNextLevelSuiteVo(exp:int) : FineSuitVo
      {
         var i:int = 0;
         var vo:* = null;
         for(i = 0; i < _model.length; )
         {
            vo = _model[i.toString()] as FineSuitVo;
            if(exp < vo.exp)
            {
               vo = _model[i.toString()] as FineSuitVo;
               return vo;
            }
            i++;
         }
         return null;
      }
      
      public function getNextSuitVoByExp(exp:int) : FineSuitVo
      {
         var i:int = 0;
         var vo:* = null;
         for(i = 0; i < _model.length; )
         {
            vo = _model[i.toString()] as FineSuitVo;
            if(exp < vo.exp)
            {
               return vo;
            }
            i++;
         }
         return vo;
      }
      
      public function updateFineSuitProperty(exp:int, dic:DictionaryData) : void
      {
         var info:FineSuitVo = getFineSuitPropertyByExp(exp);
         dic["Defence"]["FineSuit"] = info.Defence;
         dic["Agility"]["FineSuit"] = info.Agility;
         dic["Luck"]["FineSuit"] = info.Luck;
         dic["HP"]["FineSuit"] = info.hp;
         dic["MagicDefence"]["FineSuit"] = info.MagicDefence;
         dic["Armor"]["FineSuit"] = info.Armor;
         dic["MagicAttack"]["FineSuit"] = 0;
         dic["Attack"]["FineSuit"] = 0;
      }
      
      public function getFineSuitPropertyByExp(exp:int) : FineSuitVo
      {
         var i:int = 0;
         var vo:* = null;
         var level:int = getSuitVoByExp(exp).level;
         var dataVo:FineSuitVo = new FineSuitVo();
         for(i = 1; i <= level; )
         {
            vo = _model[i.toString()] as FineSuitVo;
            dataVo.Defence = dataVo.Defence + vo.Defence;
            dataVo.hp = dataVo.hp + vo.hp;
            dataVo.Luck = dataVo.Luck + vo.Luck;
            dataVo.Agility = dataVo.Agility + vo.Agility;
            dataVo.MagicDefence = dataVo.MagicDefence + vo.MagicDefence;
            dataVo.Armor = dataVo.Armor + vo.Armor;
            i++;
         }
         return dataVo;
      }
      
      public function getTipsPropertyInfoList(type:int, level:String) : Array
      {
         var j:int = 0;
         var propname:* = null;
         var value:int = 0;
         var vo:FineSuitVo = _data[type][level] as FineSuitVo;
         var valueList:Array = [];
         for(j = 0; j < propertyList.length; )
         {
            propname = propertyList[j];
            if(vo.hasOwnProperty(propname))
            {
               value = vo[propname];
               if(value != 0)
               {
                  valueList.push(nameList[j] + value);
               }
            }
            j++;
         }
         return valueList;
      }
      
      public function getTipsPropertyInfoListToString(type:int, level:String) : String
      {
         var list:Array = getTipsPropertyInfoList(type,level);
         return list.toString().replace(/,/g," ");
      }
      
      public function get materialIDList() : Array
      {
         return _materialIDList;
      }
      
      public function get tipsData() : DictionaryData
      {
         return _data;
      }
      
      public function getSuitVoByLevel(value:int) : FineSuitVo
      {
         return _model[value];
      }
   }
}

package com.yy.game
{
   import flash.net.URLVariables;
   
   public class GameProfileParams
   {
       
      
      private var _fightPower:int = -1;
      
      private var _sex:String;
      
      private var _job:String;
      
      private var _partner:String;
      
      private var _equip:String;
      
      private var _iversion:String;
      
      private var _updateVersion:String;
      
      private var _runResource:String;
      
      private var _referrer:String;
      
      public function GameProfileParams(data:Object = null)
      {
         var map:Object = null;
         var key:* = null;
         var thisKey:String = null;
         super();
         if(data)
         {
            map = {
               "equip":"equip",
               "fight_cap":"fightPower",
               "ive":"iversion",
               "job":"job",
               "partner":"partner",
               "ref":"referrer",
               "rso":"runResource",
               "sex":"sex",
               "uve":"updateVersion"
            };
            for(key in data)
            {
               thisKey = map[key];
               this[thisKey] = data[key];
            }
         }
      }
      
      public function get fightPower() : int
      {
         return this._fightPower;
      }
      
      public function set fightPower(value:int) : void
      {
         this._fightPower = value;
      }
      
      public function get sex() : String
      {
         return this._sex;
      }
      
      public function set sex(value:String) : void
      {
         if(value != Gender.MALE && value != Gender.FEMALE)
         {
            throw new ArgumentError("性别必须是Gender类的常量值");
         }
         this._sex = value;
      }
      
      public function get job() : String
      {
         return this._job;
      }
      
      public function set job(value:String) : void
      {
         if(value == null || value.length <= 0)
         {
            throw new ArgumentError("job参数不能是null或空字符串");
         }
         this._job = value;
      }
      
      public function get partner() : String
      {
         return this._partner;
      }
      
      public function set partner(value:String) : void
      {
         if(value == null || value.length <= 0)
         {
            throw new ArgumentError("partner参数不能是null或空字符串");
         }
         this._partner = value;
      }
      
      public function get equip() : String
      {
         return this._equip;
      }
      
      public function set equip(value:String) : void
      {
         if(value == null || value.length <= 0)
         {
            throw new ArgumentError("equip参数不能是null或空字符串");
         }
         this._equip = value;
      }
      
      public function get iversion() : String
      {
         return this._iversion;
      }
      
      public function set iversion(value:String) : void
      {
         if(value == null || value.length <= 0)
         {
            throw new ArgumentError("iversion参数不能是null或空字符串");
         }
         this._iversion = value;
      }
      
      public function get updateVersion() : String
      {
         if(this._updateVersion == null)
         {
            return this._iversion;
         }
         return this._updateVersion;
      }
      
      public function set updateVersion(value:String) : void
      {
         if(value == null || value.length <= 0)
         {
            throw new ArgumentError("updateVersion参数不能是null或空字符串");
         }
         this._updateVersion = value;
      }
      
      public function get runResource() : String
      {
         return this._runResource;
      }
      
      public function set runResource(value:String) : void
      {
         if(value == null || value.length <= 0)
         {
            throw new ArgumentError("runResource参数不能是null或空字符串");
         }
         this._runResource = value;
      }
      
      public function get referrer() : String
      {
         return this._referrer;
      }
      
      public function set referrer(value:String) : void
      {
         if(value == null || value.length <= 0)
         {
            throw new ArgumentError("referrer参数不能是null或空字符串");
         }
         this._referrer = value;
      }
      
      function setVariable(variable:URLVariables) : void
      {
         if(this._iversion)
         {
            variable.ive = this._iversion;
         }
         if(this._updateVersion)
         {
            variable.uve = this._updateVersion;
         }
         if(this._runResource)
         {
            variable.rso = this._runResource;
         }
         if(this._referrer)
         {
            variable.ref = this._referrer;
         }
      }
      
      private function getVal(key:String, obj:Object) : String
      {
         if(obj.hasOwnProperty(key))
         {
            return obj[key];
         }
         return null;
      }
   }
}

package gameCommon.model
{
   import calendar.CalendarManager;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffType;
   import ddt.manager.LanguageMgr;
   import gameCommon.BuffManager;
   import gameCommon.GameControl;
   
   public class FightBuffInfo
   {
      
      public static const DEFUALT_EFFECT:String = "asset.game.AttackEffect2";
      
      public static const BUFF_ID_BEING_KILLED_ADD_BLOOD:int = 1435;
      
      public static const BUFF_ID_BEING_AWAKEN_KILLED_ADD_BLOOD:int = 1514;
       
      
      public var id:int;
      
      public var displayid:int = 0;
      
      public var type:int;
      
      private var _sigh:int = -1;
      
      public var buffPic:String = "";
      
      public var buffEffect:String = "";
      
      public var buffName:String = "FightBuffInfo";
      
      public var description:String = "unkown buff";
      
      public var priority:Number = 0.0;
      
      private var _data:int;
      
      private var _level:int;
      
      public var Count:int = 1;
      
      public var showType:int;
      
      public var isSelf:Boolean;
      
      public function FightBuffInfo(param1:int)
      {
         super();
         this.id = param1;
         var _loc2_:GameBuffInfo = BuffManager.buffTemplateData[param1];
         if(_loc2_)
         {
            type = _loc2_.Type;
            buffPic = _loc2_.Pic;
            buffName = _loc2_.Name;
            description = _loc2_.Description;
            showType = _loc2_.ShowType;
         }
         else
         {
            if(BuffType.isLuckyBuff(param1))
            {
               this.buffName = LanguageMgr.GetTranslation("tank.game.BuffNameLucky",CalendarManager.getInstance().luckyNum >= 0?CalendarManager.getInstance().luckyNum:"");
            }
            else
            {
               this.buffName = LanguageMgr.GetTranslation("tank.game.BuffName" + this.id);
            }
            if(param1 == 1435 || param1 == 1514)
            {
               Count = 3;
            }
         }
      }
      
      public function get data() : int
      {
         return _data;
      }
      
      public function set data(param1:int) : void
      {
         var _loc2_:* = null;
         _data = param1;
         description = LanguageMgr.GetTranslation("tank.game.BuffTip" + id,_data);
         if(id == 243 || id == 244 || id == 245 || id == 246)
         {
            _loc2_ = GameControl.Instance.Current;
            if(_loc2_.mapIndex == 1214 || _loc2_.mapIndex == 1215 || _loc2_.mapIndex == 1216 || _loc2_.mapIndex == 1217)
            {
               description = LanguageMgr.GetTranslation("tank.game.BuffTip" + id + "1",_data);
            }
         }
      }
      
      public function execute(param1:Living) : void
      {
         if(type == 5)
         {
            if(buffEffect)
            {
               if(ModuleLoader.hasDefinition("asset.game.skill.effect." + buffEffect))
               {
                  param1.showBuffEffect("asset.game.skill.effect." + buffEffect,id);
               }
               else
               {
                  param1.showBuffEffect("asset.game.AttackEffect2",id);
               }
            }
         }
         else if(!(int(id) - 3))
         {
            param1.isLockAngle = true;
         }
      }
      
      public function unExecute(param1:Living) : void
      {
         if(type == 5)
         {
            if(buffEffect)
            {
               param1.removeBuffEffect(id);
            }
         }
         else if(!(int(id) - 3))
         {
            param1.isLockAngle = false;
         }
      }
      
      public function clone() : FightBuffInfo
      {
         var _loc1_:FightBuffInfo = new FightBuffInfo(id);
         ObjectUtils.copyProperties(_loc1_,this);
         return _loc1_;
      }
   }
}

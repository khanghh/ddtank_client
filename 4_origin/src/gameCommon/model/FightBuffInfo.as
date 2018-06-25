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
      
      public function FightBuffInfo(id:int)
      {
         super();
         this.id = id;
         var info:GameBuffInfo = BuffManager.buffTemplateData[id];
         if(info)
         {
            type = info.Type;
            buffPic = info.Pic;
            buffName = info.Name;
            description = info.Description;
            showType = info.ShowType;
         }
         else
         {
            if(BuffType.isLuckyBuff(id))
            {
               this.buffName = LanguageMgr.GetTranslation("tank.game.BuffNameLucky",CalendarManager.getInstance().luckyNum >= 0?CalendarManager.getInstance().luckyNum:"");
            }
            else
            {
               this.buffName = LanguageMgr.GetTranslation("tank.game.BuffName" + this.id);
            }
            if(id == 1435 || id == 1514)
            {
               Count = 3;
            }
         }
      }
      
      public function get data() : int
      {
         return _data;
      }
      
      public function set data(val:int) : void
      {
         var gameInfo:* = null;
         _data = val;
         description = LanguageMgr.GetTranslation("tank.game.BuffTip" + id,_data);
         if(id == 243 || id == 244 || id == 245 || id == 246)
         {
            gameInfo = GameControl.Instance.Current;
            if(gameInfo.mapIndex == 1214 || gameInfo.mapIndex == 1215 || gameInfo.mapIndex == 1216 || gameInfo.mapIndex == 1217)
            {
               description = LanguageMgr.GetTranslation("tank.game.BuffTip" + id + "1",_data);
            }
         }
      }
      
      public function execute(living:Living) : void
      {
         if(type == 5)
         {
            if(buffEffect)
            {
               if(ModuleLoader.hasDefinition("asset.game.skill.effect." + buffEffect))
               {
                  living.showBuffEffect("asset.game.skill.effect." + buffEffect,id);
               }
               else
               {
                  living.showBuffEffect("asset.game.AttackEffect2",id);
               }
            }
         }
         else if(!(int(id) - 3))
         {
            living.isLockAngle = true;
         }
      }
      
      public function unExecute(living:Living) : void
      {
         if(type == 5)
         {
            if(buffEffect)
            {
               living.removeBuffEffect(id);
            }
         }
         else if(!(int(id) - 3))
         {
            living.isLockAngle = false;
         }
      }
      
      public function clone() : FightBuffInfo
      {
         var temInfo:FightBuffInfo = new FightBuffInfo(id);
         ObjectUtils.copyProperties(temInfo,this);
         return temInfo;
      }
   }
}

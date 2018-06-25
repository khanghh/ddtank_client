package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import worldboss.WorldBossManager;
   
   public class WorldBossHPScript extends Sprite implements Disposeable
   {
       
      
      private var _bloodStrip:MovieClip;
      
      private var _bloodWidth:int;
      
      private var _hp_text:TextField;
      
      private var _bossName_text:TextField;
      
      private var _scale:Number;
      
      private var _iscuting:Boolean;
      
      private var speed:Number = 1.0;
      
      public function WorldBossHPScript()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _bloodStrip = ComponentFactory.Instance.creat("tank.worldboss.hpscript-" + WorldBossManager.Instance.BossResourceId);
         addChild(_bloodStrip);
         _bossName_text = _bloodStrip["boss_name"]["value_text"];
         _bossName_text.text = WorldBossManager.Instance.bossInfo.name;
         _hp_text = _bloodStrip["boss_hp"]["value_text"];
         refreshBlood();
      }
      
      public function refreshBossName() : void
      {
         _bossName_text.text = WorldBossManager.Instance.bossInfo.name;
      }
      
      public function refreshBlood() : void
      {
         showBloodText();
         _bloodStrip["red2_hp"].stop();
         _scale = _bloodStrip["red_hp"]["red_mask"].width / WorldBossManager.Instance.bossInfo.total_Blood;
         _bloodStrip["red_hp"]["red_mask"].x = -1 * _scale * (WorldBossManager.Instance.bossInfo.total_Blood - WorldBossManager.Instance.bossInfo.current_Blood) - 1;
         _bloodStrip["red2_hp"]["red2_mask"].x = _bloodStrip["red_hp"]["red_mask"].x;
      }
      
      private function addEvent() : void
      {
         WorldBossManager.Instance.bossInfo.addEventListener("change",updateBloodStrip);
      }
      
      private function showBloodText() : void
      {
         if(WorldBossManager.Instance.isAutoBlood)
         {
            _hp_text.text = "?????";
         }
         else
         {
            _hp_text.text = WorldBossManager.Instance.bossInfo.current_Blood + "/" + WorldBossManager.Instance.bossInfo.total_Blood;
         }
      }
      
      private function updateBloodStrip(event:Event) : void
      {
         refreshBlood();
         playCutHpMC(WorldBossManager.Instance.bossInfo.total_Blood - WorldBossManager.Instance.bossInfo.current_Blood);
         if(StateManager.currentStateType == "worldboss")
         {
            __showCutHp();
         }
      }
      
      private function playCutHpMC(value:Number) : void
      {
         _bloodStrip["red_hp"]["red_mask"].x = -1 * _scale * value - 1;
         if(!_iscuting)
         {
            _iscuting = true;
            addEventListener("enterFrame",cutHpred2);
         }
      }
      
      private function cutHpred2(e:Event) : void
      {
         if(!_bloodStrip || !_bloodStrip["red_hp"]["red_mask"] || !_bloodStrip["red2_hp"]["red2_mask"])
         {
            return;
         }
         if(_bloodStrip["red_hp"]["red_mask"].x >= _bloodStrip["red2_hp"]["red2_mask"].x)
         {
            removeEventListener("enterFrame",cutHpred2);
            _bloodStrip["red2_hp"]["red2_mask"].x = _bloodStrip["red_hp"]["red_mask"].x;
            _iscuting = false;
         }
         else
         {
            _bloodStrip["red2_hp"]["red2_mask"].x = _bloodStrip["red2_hp"]["red2_mask"].x - speed;
         }
      }
      
      private function __showCutHp() : void
      {
         var numMC:WorldBossCutHpMC = new WorldBossCutHpMC(WorldBossManager.Instance.bossInfo.cutValue);
         PositionUtils.setPos(numMC,"worldboss.numMC.pos");
         addChildAt(numMC,0);
      }
      
      private function offset(off:int = 30) : int
      {
         var i:int = Math.random() * 10;
         if(i % 2 == 0)
         {
            return -(int(Math.random() * off));
         }
         return int(Math.random() * off);
      }
      
      public function dispose() : void
      {
         WorldBossManager.Instance.bossInfo.removeEventListener("change",updateBloodStrip);
         if(_bloodStrip)
         {
            removeChild(_bloodStrip);
         }
         _bloodStrip = null;
         _bossName_text = null;
         _hp_text = null;
      }
   }
}

package demonChiYou.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import demonChiYou.DemonChiYouManager;
   import demonChiYou.DemonChiYouModel;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class WorldBossHPScript extends Sprite implements Disposeable
   {
       
      
      private var _bloodStrip:MovieClip;
      
      private var _bloodWidth:int;
      
      private var _hp_text:TextField;
      
      private var _bossName_text:TextField;
      
      private var _scale:Number;
      
      private var _iscuting:Boolean;
      
      private var speed:Number = 1.0;
      
      private var _mgr:DemonChiYouManager;
      
      private var _model:DemonChiYouModel;
      
      public function WorldBossHPScript()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _mgr = DemonChiYouManager.instance;
         _model = _mgr.model;
         _bloodStrip = ComponentFactory.Instance.creat("DemonChiYou.hpscript");
         addChild(_bloodStrip);
         _bossName_text = _bloodStrip["boss_name"]["value_text"];
         _bossName_text.text = "魔神蚩尤";
         _hp_text = _bloodStrip["boss_hp"]["value_text"];
         refreshBlood();
      }
      
      public function refreshBlood() : void
      {
         showBloodText();
         _bloodStrip["red2_hp"].stop();
         _scale = _bloodStrip["red_hp"]["red_mask"].width / _model.bossMaxBlood;
         _bloodStrip["red_hp"]["red_mask"].x = -1 * _scale * (_model.bossMaxBlood - _model.bossBlood) - 1;
         _bloodStrip["red2_hp"]["red2_mask"].x = _bloodStrip["red_hp"]["red_mask"].x;
      }
      
      private function addEvent() : void
      {
         _mgr.addEventListener("event_boss_info_back",updateBloodStrip);
      }
      
      private function showBloodText() : void
      {
         _hp_text.text = _model.bossBlood + "/" + _model.bossMaxBlood;
      }
      
      private function updateBloodStrip(event:Event) : void
      {
         refreshBlood();
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
         _mgr.removeEventListener("event_boss_info_back",updateBloodStrip);
         ObjectUtils.disposeAllChildren(this);
         _bloodStrip = null;
         _hp_text = null;
         _bossName_text = null;
         _mgr = null;
         _model = null;
      }
   }
}

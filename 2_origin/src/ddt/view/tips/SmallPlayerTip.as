package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class SmallPlayerTip extends BaseTip implements ITip
   {
      
      private static var _instance:SmallPlayerTip;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _lv:Bitmap;
      
      private var _ddtKingGradeText:FilterFrameText;
      
      private var _winRate:WinRate;
      
      private var _battle:Battle;
      
      private var _tipContainer:Sprite;
      
      private var _nameField:FilterFrameText;
      
      private var _level:int;
      
      private var _reputeCount:int;
      
      private var _win:int;
      
      private var _total:int;
      
      private var _enableTip:Boolean;
      
      private var _tip:Sprite;
      
      private var _tipInfo:Object;
      
      private var _battleNum:int;
      
      private var _exploitValue:int;
      
      private var _bgH:int;
      
      public function SmallPlayerTip()
      {
         if(!_instance)
         {
            super();
            _instance = this;
         }
      }
      
      public static function get instance() : SmallPlayerTip
      {
         if(!instance)
         {
            _instance = new SmallPlayerTip();
         }
         return _instance;
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         this._tipbackgound = _bg;
         _lv = ComponentFactory.Instance.creatBitmap("asset.core.leveltip.LevelTipLv");
         _lv.x = 4;
         _lv.y = 28;
         _ddtKingGradeText = ComponentFactory.Instance.creatComponentByStylename("ddt.levelTips.ddtKingGradeText");
         PositionUtils.setPos(_ddtKingGradeText,"simllPlayerTips.ddtkingGradeTextPos");
         createLevelTip();
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         _nameField = ComponentFactory.Instance.creatComponentByStylename("game.smallplayer.NameField");
         addChild(_nameField);
         addChild(_lv);
         addChild(_ddtKingGradeText);
         addChild(_tipContainer);
         updateWH();
      }
      
      public function get txtPos() : Point
      {
         var _loc1_:Point = new Point();
         if(_lv)
         {
            _loc1_.x = _lv.x + _lv.width + 3;
            _loc1_.y = _lv.y + 4;
         }
         return _loc1_;
      }
      
      override public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(param1 is LevelTipInfo)
         {
            this.visible = true;
            makeTip(param1);
         }
         else
         {
            this.visible = false;
         }
         _tipInfo = param1;
      }
      
      private function updateWH() : void
      {
         _width = _bg.width;
         _height = _bg.height;
      }
      
      private function createLevelTip() : void
      {
         _tipContainer = new Sprite();
         _winRate = new WinRate(_win,_total);
         _battle = new Battle(_battleNum);
         _winRate.y = 52;
         _battle.y = 77;
         var _loc1_:int = 10;
         _battle.x = _loc1_;
         _winRate.x = _loc1_;
         _tipContainer.addChild(_winRate);
         _tipContainer.addChild(_battle);
      }
      
      private function makeTip(param1:Object) : void
      {
         if(param1)
         {
            resetLevelTip(param1.Level,param1.ddtKingGraed,param1.Repute,param1.Win,param1.Total,param1.Battle,param1.exploit,param1.enableTip,param1.team,param1.nickName);
         }
      }
      
      private function resetLevelTip(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean = true, param9:int = 1, param10:String = "") : void
      {
         var _loc11_:* = undefined;
         _level = param1;
         _reputeCount = param3;
         _win = param4;
         _total = param5;
         _exploitValue = param7;
         _enableTip = param8;
         _nameField.text = param10;
         this.visible = _enableTip;
         if(!_enableTip)
         {
            return;
         }
         setRepute(_level,_reputeCount);
         if(param2 > 0)
         {
            _ddtKingGradeText.text = "+" + param2;
         }
         else
         {
            _ddtKingGradeText.text = "";
         }
         setRate(param4,param5);
         setBattle(param6);
         setExploit(_exploitValue);
         if(_bgH == 0)
         {
            _bgH = _bg.height;
         }
         if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "trainer1" || StateManager.currentStateType == "trainer2" || StateManager.currentStateType == "fightLabGameView")
         {
            _loc11_ = getDefinitionByName("gameCommon.GameControl");
            if(_loc11_)
            {
               if(param9 != _loc11_.Instance.Current.selfGamePlayer.team)
               {
                  _battle.visible = false;
                  _bg.height = _bgH - 20 - 20;
               }
               else
               {
                  _battle.visible = true;
                  _bg.height = _bgH - 20;
               }
            }
         }
         else
         {
            _battle.visible = true;
            _bg.height = _bgH - 20;
         }
         updateTip();
      }
      
      private function setRepute(param1:int, param2:int) : void
      {
      }
      
      private function setRate(param1:int, param2:int) : void
      {
         _winRate.setRate(param1,param2);
      }
      
      private function setBattle(param1:int) : void
      {
         _battle.BattleNum = param1;
      }
      
      private function setExploit(param1:int) : void
      {
      }
      
      private function updateTip() : void
      {
         if(_tip)
         {
            this.removeChild(_tip);
         }
         _tip = new Sprite();
         LevelPicCreater.creatLevelPicInContainer(_tip,_level,int(txtPos.x),int(txtPos.y));
         addChild(_tip);
         _bg.width = _tipContainer.width + 15;
         updateWH();
      }
      
      override public function dispose() : void
      {
         if(_tip)
         {
            if(_tip.parent)
            {
               _tip.parent.removeChild(_tip);
            }
         }
         _tip = null;
         if(_tipContainer)
         {
            if(_tipContainer.parent)
            {
               _tipContainer.parent.removeChild(_tipContainer);
            }
         }
         _tipContainer = null;
         ObjectUtils.disposeObject(_winRate);
         _winRate = null;
         ObjectUtils.disposeObject(_battle);
         _battle = null;
         if(_lv)
         {
            ObjectUtils.disposeObject(_lv);
         }
         _lv = null;
         ObjectUtils.disposeObject(_ddtKingGradeText);
         _ddtKingGradeText = null;
         ObjectUtils.disposeAllChildren(this);
         _instance = null;
         super.dispose();
      }
   }
}

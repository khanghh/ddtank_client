package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   
   public class LevelTip extends BaseTip implements ITip
   {
      
      private static var _instance:LevelTip;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _lv:Bitmap;
      
      private var _ddtKingGradeText:FilterFrameText;
      
      private var _repute:Repute;
      
      private var _winRate:WinRate;
      
      private var _battle:Battle;
      
      private var _exploit:Exploit;
      
      private var _tipContainer:Sprite;
      
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
      
      public function LevelTip()
      {
         if(!_instance)
         {
            super();
            _instance = this;
         }
      }
      
      public static function get instance() : LevelTip
      {
         if(!instance)
         {
            _instance = new LevelTip();
         }
         return _instance;
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         this._tipbackgound = _bg;
         _lv = ComponentFactory.Instance.creatBitmap("asset.core.leveltip.LevelTipLv");
         createLevelTip();
         super.init();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_lv);
         addChild(_tipContainer);
         updateWH();
      }
      
      public function get txtPos() : Point
      {
         var ret:Point = new Point();
         if(_lv)
         {
            ret.x = _lv.x + _lv.width + 3;
            ret.y = _lv.y + 4;
         }
         return ret;
      }
      
      override public function get tipData() : Object
      {
         return _tipInfo;
      }
      
      override public function set tipData(data:Object) : void
      {
         this.visible = true;
         makeTip(data);
         _tipInfo = data;
      }
      
      private function updateWH() : void
      {
         _width = _bg.width;
         _height = _bg.height;
      }
      
      private function createLevelTip() : void
      {
         _tipContainer = new Sprite();
         _repute = new Repute(_reputeCount,_level);
         _repute.align = "left";
         _winRate = new WinRate(_win,_total);
         _battle = new Battle(_battleNum);
         _exploit = new Exploit(_exploitValue);
         _ddtKingGradeText = ComponentFactory.Instance.creatComponentByStylename("ddt.levelTips.ddtKingGradeText");
         var _loc1_:* = 10;
         _exploit.x = _loc1_;
         _loc1_ = _loc1_;
         _battle.x = _loc1_;
         _loc1_ = _loc1_;
         _winRate.x = _loc1_;
         _repute.x = _loc1_;
         _repute.y = 27;
         _winRate.y = 52;
         _battle.y = 77;
         _exploit.y = 102;
         _tipContainer.addChild(_repute);
         _tipContainer.addChild(_winRate);
         _tipContainer.addChild(_battle);
         _tipContainer.addChild(_exploit);
         _tipContainer.addChild(_ddtKingGradeText);
      }
      
      private function makeTip(obj:Object) : void
      {
         if(obj)
         {
            resetLevelTip(obj.Level,obj.ddtKingGraed,obj.Repute,obj.Win,obj.Total,obj.Battle,obj.exploit,obj.enableTip,obj.team);
         }
      }
      
      private function resetLevelTip(lv:int, ddtKingGraed:int, repute:int, win:int, total:int, battle:int, exploit:int, enableTip:Boolean = true, team:int = 1) : void
      {
         var gameControl:* = undefined;
         _level = lv;
         _reputeCount = repute;
         _win = win;
         _total = total;
         _exploitValue = exploit;
         _enableTip = enableTip;
         this.visible = _enableTip;
         if(!_enableTip)
         {
            return;
         }
         setRepute(_level,_reputeCount);
         if(ddtKingGraed > 0)
         {
            _ddtKingGradeText.text = "+" + ddtKingGraed;
         }
         else
         {
            _ddtKingGradeText.text = "";
         }
         setRate(win,total);
         setBattle(battle);
         setExploit(_exploitValue);
         if(_bgH == 0)
         {
            _bgH = _bg.height;
         }
         trace(StateManager.currentStateType);
         if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "trainer1" || StateManager.currentStateType == "trainer2" || StateManager.currentStateType == "fightLabGameView" || StateManager.currentStateType == "gameLoading")
         {
            gameControl = getDefinitionByName("gameCommon.GameControl");
            if(gameControl)
            {
               if(team != gameControl.Instance.Current.selfGamePlayer.team)
               {
                  _battle.visible = false;
                  _exploit.y = 77;
                  _bg.height = _bgH - 20;
               }
               else
               {
                  _battle.visible = true;
                  _exploit.y = 102;
                  _bg.height = _bgH;
               }
            }
         }
         else
         {
            _battle.visible = true;
            _exploit.y = 102;
            _bg.height = _bgH;
         }
         updateTip();
      }
      
      private function setRepute(level:int, reputeCount:int) : void
      {
         _repute.level = level;
         _repute.setRepute(reputeCount);
      }
      
      private function setRate($win:int, $total:int) : void
      {
         _winRate.setRate($win,$total);
      }
      
      private function setBattle(num:int) : void
      {
         _battle.BattleNum = num;
      }
      
      private function setExploit(value:int) : void
      {
         _exploit.exploitNum = value;
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
         ObjectUtils.disposeObject(_repute);
         _repute = null;
         ObjectUtils.disposeObject(_winRate);
         _winRate = null;
         ObjectUtils.disposeObject(_battle);
         _battle = null;
         ObjectUtils.disposeObject(_exploit);
         _exploit = null;
         ObjectUtils.disposeObject(_ddtKingGradeText);
         _ddtKingGradeText = null;
         if(_lv)
         {
            ObjectUtils.disposeObject(_lv);
         }
         _lv = null;
         ObjectUtils.disposeObject(this);
         _instance = null;
         super.dispose();
      }
   }
}

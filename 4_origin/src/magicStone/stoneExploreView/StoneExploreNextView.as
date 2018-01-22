package magicStone.stoneExploreView
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import game.GameManager;
   import gameCommon.GameControl;
   
   public class StoneExploreNextView extends Sprite
   {
       
      
      private var ACTIVITYDUNGEONPOINTSNUM:String = "asset.game.nextView.count_";
      
      private var _numBitmapArray:Array;
      
      private var _cdData:Number = 0;
      
      private var _id:int;
      
      private var _bg:Bitmap;
      
      private var _nextBtn:BaseButton;
      
      private var _quitBtn:BaseButton;
      
      private var _hBox:HBox;
      
      private var _isNext:Boolean;
      
      private var _playerBlood:int;
      
      private var _quiTxt:FilterFrameText;
      
      private var _posStr:String = "333,-302|307,-302|277,-302|243,-302|210,-302|165,-302|127,-302";
      
      public function StoneExploreNextView(param1:int, param2:Boolean = false)
      {
         super();
         _id = param1;
         _isNext = param2;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         mouseChildren = true;
         _playerBlood = PlayerManager.Instance.Self.Blood;
         _bg = ComponentFactory.Instance.creatBitmap("magicStone.stoneExplore.BG");
         addChild(_bg);
         _quitBtn = ComponentFactory.Instance.creat("magicStone.StoneExploreNextView.quitBtn");
         addChild(_quitBtn);
         if(_isNext)
         {
            _nextBtn = ComponentFactory.Instance.creat("magicStone.StoneExploreNextView.nextBtn");
            addChild(_nextBtn);
         }
         else
         {
            PositionUtils.setPos(_quitBtn,"magicStone.StoneExploreNextView.quitBtnPos");
         }
      }
      
      public function setQuitPos() : void
      {
         _quiTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.StoneExploreNextView.quiTxt");
         _quiTxt.text = LanguageMgr.GetTranslation("magicStone.StoneExploreNextView.quiTxtLG");
         addChild(_quiTxt);
      }
      
      private function initEvent() : void
      {
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__nextBtnHandler);
         }
         _quitBtn.addEventListener("click",__quitBtnHandler);
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function __nextBtnHandler(param1:MouseEvent) : void
      {
         GameInSocketOut.sendGameMissionStart(_isNext);
         dispose();
      }
      
      private function __quitBtnHandler(param1:MouseEvent) : void
      {
         GameManager.exploreOver = true;
         StateManager.setState("main");
      }
      
      public function setData(param1:Array) : void
      {
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc10_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc9_:Object = {};
         if(param1.length <= _posStr.length)
         {
            _loc2_ = _posStr.split("|");
            _loc6_ = _loc2_[param1.length - 1].toString().split(",");
            _loc9_.x = int(_loc6_[0]);
            _loc9_.y = int(_loc6_[1]);
         }
         else
         {
            _loc9_.x = 130;
            _loc9_.y = -302;
         }
         _hBox = new HBox();
         _hBox.spacing = 8;
         PositionUtils.setPos(_hBox,_loc9_);
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            _loc3_ = param1[_loc10_].toString().split(",");
            _loc5_ = new Sprite();
            _loc7_ = ItemManager.Instance.getTemplateById(_loc3_[0]) as ItemTemplateInfo;
            _loc7_.Level = 1;
            _loc4_ = new BagCell(0,_loc7_,false);
            _loc4_.setCount(_loc3_[1]);
            _loc4_.x = 5;
            _loc4_.y = 5;
            _loc4_.setBgVisible(false);
            _loc8_ = ComponentFactory.Instance.creatBitmap("magicStone.stoneExplore.GoodsFrame");
            _loc5_.addChild(_loc8_);
            _loc5_.addChild(_loc4_);
            _hBox.addChild(_loc5_);
            _loc10_++;
         }
         addChild(_hBox);
      }
      
      public function setBtnEnable() : void
      {
         if(_nextBtn)
         {
            _nextBtn.enable = false;
         }
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_hBox)
         {
            ObjectUtils.disposeObject(_hBox);
            _hBox = null;
         }
         if(_quiTxt)
         {
            ObjectUtils.disposeObject(_quiTxt);
            _quiTxt = null;
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__nextBtnHandler);
            _nextBtn.dispose();
            _nextBtn = null;
         }
         if(_quitBtn)
         {
            _quitBtn.removeEventListener("click",__quitBtnHandler);
            _quitBtn.dispose();
            _quitBtn = null;
         }
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function get Id() : int
      {
         return _id;
      }
   }
}

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
      
      public function StoneExploreNextView(id:int, isNext:Boolean = false)
      {
         super();
         _id = id;
         _isNext = isNext;
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
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         ChatManager.Instance.input.faceEnabled = false;
         LayerManager.Instance.clearnGameDynamic();
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function __nextBtnHandler(evt:MouseEvent) : void
      {
         GameInSocketOut.sendGameMissionStart(_isNext);
         dispose();
      }
      
      private function __quitBtnHandler(evt:MouseEvent) : void
      {
         GameManager.exploreOver = true;
         StateManager.setState("main");
      }
      
      public function setData(info:Array) : void
      {
         var posArr:* = null;
         var infoArr:* = null;
         var i:int = 0;
         var arr:* = null;
         var sprite:* = null;
         var itemInfo:* = null;
         var cell:* = null;
         var cellBg:* = null;
         var obj:Object = {};
         if(info.length <= _posStr.length)
         {
            posArr = _posStr.split("|");
            infoArr = posArr[info.length - 1].toString().split(",");
            obj.x = int(infoArr[0]);
            obj.y = int(infoArr[1]);
         }
         else
         {
            obj.x = 130;
            obj.y = -302;
         }
         _hBox = new HBox();
         _hBox.spacing = 8;
         PositionUtils.setPos(_hBox,obj);
         for(i = 0; i < info.length; )
         {
            arr = info[i].toString().split(",");
            sprite = new Sprite();
            itemInfo = ItemManager.Instance.getTemplateById(arr[0]) as ItemTemplateInfo;
            itemInfo.Level = 1;
            cell = new BagCell(0,itemInfo,false);
            cell.setCount(arr[1]);
            cell.x = 5;
            cell.y = 5;
            cell.setBgVisible(false);
            cellBg = ComponentFactory.Instance.creatBitmap("magicStone.stoneExplore.GoodsFrame");
            sprite.addChild(cellBg);
            sprite.addChild(cell);
            _hBox.addChild(sprite);
            i++;
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

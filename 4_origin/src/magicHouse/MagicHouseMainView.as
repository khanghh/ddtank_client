package magicHouse
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import magicHouse.magicBox.MagicHouseBoxView;
   import magicHouse.magicCollection.MagicHouseCollectionMainView;
   import magicHouse.treasureHouse.MagicHouseTreasureHouseView;
   
   public class MagicHouseMainView extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _collectionBtn:SelectedButton;
      
      private var _treasureBtn:SelectedButton;
      
      private var _boxBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _collectionView:MagicHouseCollectionMainView;
      
      private var _treasureView:MagicHouseTreasureHouseView;
      
      private var _magicBoxView:MagicHouseBoxView;
      
      public function MagicHouseMainView()
      {
         super();
         titleText = LanguageMgr.GetTranslation("magichouse.mainview.frametitletext");
         escEnable = true;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         MagicHouseControl.instance.initServerConfig();
         _bg = ComponentFactory.Instance.creatComponentByStylename("magicHouse.mainViewFrame.bg");
         addToContent(_bg);
         _collectionBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.mainViewFrame.collectionBtn");
         addToContent(_collectionBtn);
         _treasureBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.mainViewFrame.treasureBtn");
         addToContent(_treasureBtn);
         _boxBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.mainViewFrame.boxBtn");
         addToContent(_boxBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_collectionBtn);
         _btnGroup.addSelectItem(_treasureBtn);
         _btnGroup.addSelectItem(_boxBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__response);
         _btnGroup.addEventListener("change",__changeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         _btnGroup.removeEventListener("change",__changeHandler);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __changeHandler(param1:Event) : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _showCollectionView();
               break;
            case 1:
               _showTreasureView();
               break;
            case 2:
               _showMagicBoxView();
         }
      }
      
      private function _showCollectionView() : void
      {
         if(!_collectionView)
         {
            _collectionView = ComponentFactory.Instance.creatCustomObject("magicHouse.magicHouseCollectionMainView");
            addToContent(_collectionView);
         }
         _collectionView.visible = true;
         if(_treasureView)
         {
            _treasureView.visible = false;
         }
         if(_magicBoxView)
         {
            _magicBoxView.visible = false;
         }
         MagicHouseControl.instance.selectEquipFromBag();
         MagicHouseManager.instance.dispatchEvent(new Event("magichouse_updata"));
      }
      
      private function _showTreasureView() : void
      {
         if(!_treasureView)
         {
            _treasureView = ComponentFactory.Instance.creatCustomObject("magicHouse.magicHouseTreasureHouseView");
            addToContent(_treasureView);
         }
         _treasureView.info = PlayerManager.Instance.Self;
         _treasureView.visible = true;
         if(_collectionView)
         {
            _collectionView.visible = false;
         }
         if(_magicBoxView)
         {
            _magicBoxView.visible = false;
         }
      }
      
      private function _showMagicBoxView() : void
      {
         if(!_magicBoxView)
         {
            _magicBoxView = ComponentFactory.Instance.creatCustomObject("magicHouse.magicBoxMainView");
            addToContent(_magicBoxView);
         }
         _magicBoxView.visible = true;
         if(_collectionView)
         {
            _collectionView.visible = false;
         }
         if(_treasureView)
         {
            _treasureView.visible = false;
         }
      }
      
      public function show(param1:int = 0) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
         _btnGroup.selectIndex = param1;
      }
      
      public function close() : void
      {
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_collectionBtn)
         {
            ObjectUtils.disposeObject(_collectionBtn);
         }
         _collectionBtn = null;
         if(_treasureBtn)
         {
            ObjectUtils.disposeObject(_treasureBtn);
         }
         _treasureBtn = null;
         if(_boxBtn)
         {
            ObjectUtils.disposeObject(_boxBtn);
         }
         _boxBtn = null;
         if(_btnGroup)
         {
            ObjectUtils.disposeObject(_btnGroup);
         }
         _btnGroup = null;
         if(_collectionView)
         {
            ObjectUtils.disposeObject(_collectionView);
         }
         _collectionView = null;
         if(_treasureView)
         {
            ObjectUtils.disposeObject(_treasureView);
         }
         _treasureView = null;
         if(_magicBoxView)
         {
            ObjectUtils.disposeObject(_magicBoxView);
         }
         _magicBoxView = null;
         super.dispose();
      }
   }
}

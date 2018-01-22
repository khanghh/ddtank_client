package cryptBoss.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import cryptBoss.CryptBossControl;
   import cryptBoss.data.CryptBossItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class CryptBossSetFrame extends Frame
   {
       
      
      private var _data:CryptBossItemInfo;
      
      private var _bossIcon:Bitmap;
      
      private var _itemBg:Bitmap;
      
      private var _levelBg:Bitmap;
      
      private var _fightBtn:SimpleBitmapButton;
      
      private var _levelComboBox:ComboBox;
      
      private var _levelArr:Array;
      
      private var _cellVec:Vector.<BaseCell>;
      
      private var _list:SimpleTileList;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _level:int;
      
      private var _clickTime:Number = 0;
      
      public function CryptBossSetFrame(param1:CryptBossItemInfo)
      {
         super();
         _data = param1;
         _levelArr = LanguageMgr.GetTranslation("cryptBoss.setFrame.levelTxt").split(",");
         _cellVec = new Vector.<BaseCell>();
         _level = _data.star == 5?_data.star:_data.star + 1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("cryptBoss.setFrame.titleTxt");
         _bossIcon = ComponentFactory.Instance.creat("asset.cryptBoss.boss" + _data.id);
         PositionUtils.setPos(_bossIcon,"cryptBoss.setFrame.bossPos");
         addToContent(_bossIcon);
         _itemBg = ComponentFactory.Instance.creat("asset.cryptBoss.itemBg");
         addToContent(_itemBg);
         _levelBg = ComponentFactory.Instance.creat("asset.cryptBoss.levelSelect");
         addToContent(_levelBg);
         _levelComboBox = ComponentFactory.Instance.creatComponentByStylename("cryptBoss.levelChooseComboBox");
         addToContent(_levelComboBox);
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("cryptBoss.fightBtn");
         addToContent(_fightBtn);
         _fightBtn.enable = _data.state == 1;
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("cryptBoss.setFrame.dropListPanel");
         _scrollPanel.vScrollProxy = 1;
         _scrollPanel.hScrollProxy = 2;
         addToContent(_scrollPanel);
         _list = new SimpleTileList(5);
         _list.hSpace = 4;
         _list.vSpace = 5;
         updateLevelComboBox();
         updateItems();
      }
      
      private function updateItems() : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:* = null;
         while(_cellVec.length > 0)
         {
            _loc4_ = _cellVec.shift();
            _loc4_.dispose();
         }
         var _loc3_:Array = CryptBossControl.instance.getTemplateIdArr(50200 + _data.id,_level);
         var _loc6_:Rectangle = ComponentFactory.Instance.creatCustomObject("cryptBoss.setFrame.cellRect");
         var _loc8_:int = 0;
         var _loc7_:* = _loc3_;
         for each(var _loc1_ in _loc3_)
         {
            _loc2_ = ItemManager.Instance.getTemplateById(_loc1_);
            _loc5_ = new BaseCell(ComponentFactory.Instance.creatBitmap("cryptBoss.dropCellBgAsset"),_loc2_);
            _loc5_.setContentSize(_loc6_.width,_loc6_.height);
            _loc5_.PicPos = new Point(_loc6_.x,_loc6_.y);
            _list.addChild(_loc5_);
            _cellVec.push(_loc5_);
         }
         _scrollPanel.setView(_list);
         _scrollPanel.invalidateViewport();
      }
      
      private function updateLevelComboBox() : void
      {
         var _loc2_:int = 0;
         _levelComboBox.beginChanges();
         _levelComboBox.selctedPropName = "text";
         var _loc1_:VectorListModel = _levelComboBox.listPanel.vectorListModel;
         _loc1_.clear();
         _loc2_ = 0;
         while(_loc2_ < _data.star + 1 && _loc2_ < _levelArr.length)
         {
            _loc1_.append(_levelArr[_loc2_]);
            _loc2_++;
         }
         _levelComboBox.listPanel.list.updateListView();
         _levelComboBox.commitChanges();
         _levelComboBox.textField.text = _levelArr[_level - 1];
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         if(_level == param1.index + 1)
         {
            return;
         }
         _level = param1.index + 1;
         updateItems();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _levelComboBox.listPanel.list.addEventListener("listItemClick",__itemClick);
         _levelComboBox.button.addEventListener("click",__buttonClick);
         _fightBtn.addEventListener("click",__fightHandler);
      }
      
      protected function __fightHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade < 45)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",45));
            return;
         }
         CheckWeaponManager.instance.setFunction(this,__fightHandler,[param1]);
         if(CheckWeaponManager.instance.isNoWeapon())
         {
            CheckWeaponManager.instance.showAlert();
            return;
         }
         if(new Date().time - _clickTime > 1000)
         {
            _clickTime = new Date().time;
            SocketManager.Instance.out.sendCryptBossFight(_data.id,_level);
         }
      }
      
      private function __buttonClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _levelComboBox.listPanel.list.removeEventListener("listItemClick",__itemClick);
         _levelComboBox.button.removeEventListener("click",__buttonClick);
         _fightBtn.removeEventListener("click",__fightHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bossIcon = null;
         _itemBg = null;
         _levelBg = null;
         _fightBtn = null;
         _levelComboBox = null;
         _list = null;
         _scrollPanel = null;
         _cellVec = null;
      }
   }
}

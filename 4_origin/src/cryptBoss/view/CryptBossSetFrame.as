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
      
      public function CryptBossSetFrame(data:CryptBossItemInfo)
      {
         super();
         _data = data;
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
         var cell:* = null;
         var item:* = null;
         var cell1:* = null;
         while(_cellVec.length > 0)
         {
            cell = _cellVec.shift();
            cell.dispose();
         }
         var idArr:Array = CryptBossControl.instance.getTemplateIdArr(50200 + _data.id,_level);
         var rect:Rectangle = ComponentFactory.Instance.creatCustomObject("cryptBoss.setFrame.cellRect");
         var _loc8_:int = 0;
         var _loc7_:* = idArr;
         for each(var id in idArr)
         {
            item = ItemManager.Instance.getTemplateById(id);
            cell1 = new BaseCell(ComponentFactory.Instance.creatBitmap("cryptBoss.dropCellBgAsset"),item);
            cell1.setContentSize(rect.width,rect.height);
            cell1.PicPos = new Point(rect.x,rect.y);
            _list.addChild(cell1);
            _cellVec.push(cell1);
         }
         _scrollPanel.setView(_list);
         _scrollPanel.invalidateViewport();
      }
      
      private function updateLevelComboBox() : void
      {
         var i:int = 0;
         _levelComboBox.beginChanges();
         _levelComboBox.selctedPropName = "text";
         var comboxModel:VectorListModel = _levelComboBox.listPanel.vectorListModel;
         comboxModel.clear();
         i = 0;
         while(i < _data.star + 1 && i < _levelArr.length)
         {
            comboxModel.append(_levelArr[i]);
            i++;
         }
         _levelComboBox.listPanel.list.updateListView();
         _levelComboBox.commitChanges();
         _levelComboBox.textField.text = _levelArr[_level - 1];
      }
      
      private function __itemClick(event:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
         if(_level == event.index + 1)
         {
            return;
         }
         _level = event.index + 1;
         updateItems();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _levelComboBox.listPanel.list.addEventListener("listItemClick",__itemClick);
         _levelComboBox.button.addEventListener("click",__buttonClick);
         _fightBtn.addEventListener("click",__fightHandler);
      }
      
      protected function __fightHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade < 45)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",45));
            return;
         }
         CheckWeaponManager.instance.setFunction(this,__fightHandler,[event]);
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
      
      private function __buttonClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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

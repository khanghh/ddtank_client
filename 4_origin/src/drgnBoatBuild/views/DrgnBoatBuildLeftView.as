package drgnBoatBuild.views
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import drgnBoatBuild.DrgnBoatBuildCellInfo;
   import drgnBoatBuild.DrgnBoatBuildManager;
   import drgnBoatBuild.components.BuildProgress;
   import drgnBoatBuild.event.DrgnBoatBuildEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DrgnBoatBuildLeftView extends Sprite implements Disposeable
   {
       
      
      private var _leftBg:Bitmap;
      
      private var _titleBmp:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _progress:BuildProgress;
      
      private var _staticBuilding:MovieClip;
      
      private var _descriptionTxt:FilterFrameText;
      
      private var _ownImg:Bitmap;
      
      private var _ownedBeard:FilterFrameText;
      
      private var _ownedWood:FilterFrameText;
      
      private var _btn:SimpleBitmapButton;
      
      private var _itemBg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _complete:Bitmap;
      
      private var _backBtn:SimpleBitmapButton;
      
      private var _cell:BagCell;
      
      private var _tipTouchArea:Component;
      
      private var _stage:int;
      
      private var _isSelf:Boolean = true;
      
      private var _userId:int;
      
      public function DrgnBoatBuildLeftView()
      {
         super();
         initView();
         initEvents();
         SocketManager.Instance.out.updateDrgnBoatBuildInfo();
      }
      
      private function initView() : void
      {
         _leftBg = ComponentFactory.Instance.creat("drgnBoatBuild.leftViewBg");
         addChild(_leftBg);
         _titleBmp = ComponentFactory.Instance.creat("drgnBoatBuild.title");
         addChild(_titleBmp);
         _progress = new BuildProgress();
         PositionUtils.setPos(_progress,"drgnBoatBuild.progressPos");
         addChild(_progress);
         _staticBuilding = ComponentFactory.Instance.creat("drgnBoatBuild.staticBuilding");
         addChild(_staticBuilding);
         _staticBuilding.x = 186;
         _staticBuilding.y = 236;
         _staticBuilding.scaleX = 0.8;
         _staticBuilding.scaleY = 0.8;
         _staticBuilding.gotoAndStop(1);
      }
      
      public function setView() : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         removeEvents();
         clear();
         _staticBuilding.gotoAndStop(_stage + 1);
         if(_stage != 0 && !DrgnBoatBuildManager.instance.isMcPlay)
         {
            _loc2_ = _staticBuilding["boat" + _stage] as MovieClip;
            _loc2_.gotoAndStop(_loc2_.totalFrames);
         }
         DrgnBoatBuildManager.instance.isMcPlay = false;
         if(!_isSelf)
         {
            _titleBmp.visible = false;
            _titleTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.titleTxt");
            addChild(_titleTxt);
            _descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.descriptionTxt");
            addChild(_descriptionTxt);
            _descriptionTxt.text = LanguageMgr.GetTranslation("drgnBoatBuild.description");
            _btn = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.helpBuildBtn");
            addChild(_btn);
            _backBtn = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.backBtn");
            addChild(_backBtn);
         }
         else
         {
            _titleBmp.visible = true;
            switch(int(_stage))
            {
               case 0:
                  _descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.descriptionTxt");
                  addChild(_descriptionTxt);
                  _descriptionTxt.text = LanguageMgr.GetTranslation("drgnBoatBuild.description3");
                  _ownImg = ComponentFactory.Instance.creat("drgnBoatBuild.ownImg");
                  addChild(_ownImg);
                  _ownedBeard = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.ownedTxt");
                  addChild(_ownedBeard);
                  _ownedWood = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.ownedTxt");
                  PositionUtils.setPos(_ownedWood,"drgnBoatBuild.ownedTxtPos2");
                  addChild(_ownedWood);
                  _btn = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.commitBtn");
                  addChild(_btn);
                  _loc4_ = ServerConfigManager.instance.getDragonBoatBuildStage(0);
                  _loc3_ = _loc4_[0].split(",");
                  _loc1_ = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(int(_loc3_[0]));
                  _ownedWood.text = _loc1_ + "/" + _loc3_[1];
                  _loc3_ = _loc4_[1].split(",");
                  _loc1_ = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(int(_loc3_[0]));
                  _ownedBeard.text = _loc1_ + "/" + _loc3_[1];
                  break;
               case 1:
                  _descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.descriptionTxt");
                  addChild(_descriptionTxt);
                  PositionUtils.setPos(_descriptionTxt,"drgnBoatBuild.descriptionTxtPos");
                  _itemBg = ComponentFactory.Instance.creat("drgnBoatBuild.itemBg");
                  addChild(_itemBg);
                  _cell = new BagCell(0);
                  PositionUtils.setPos(_cell,"drgnBoatBuild.cellPos");
                  addChild(_cell);
                  _cell.scaleX = 1.3;
                  _cell.scaleY = 1.3;
                  _countTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.countTxt");
                  addChild(_countTxt);
                  _btn = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.secondBuildBtn");
                  addChild(_btn);
                  _loc4_ = ServerConfigManager.instance.getDragonBoatBuildStage(1);
                  _loc3_ = _loc4_[0].split(",");
                  _loc1_ = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(int(_loc3_[0]));
                  _countTxt.text = _loc1_ + "/" + _loc3_[1];
                  _descriptionTxt.text = LanguageMgr.GetTranslation("drgnBoatBuild.description2",_loc3_[1]);
                  _loc5_ = new InventoryItemInfo();
                  _loc5_.TemplateID = _loc3_[0];
                  _loc5_ = ItemManager.fill(_loc5_);
                  _loc5_.BindType = 4;
                  _cell.info = _loc5_;
                  _cell.setCountNotVisible();
                  break;
               case 2:
                  _descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.descriptionTxt");
                  addChild(_descriptionTxt);
                  PositionUtils.setPos(_descriptionTxt,"drgnBoatBuild.descriptionTxtPos");
                  _itemBg = ComponentFactory.Instance.creat("drgnBoatBuild.itemBg");
                  addChild(_itemBg);
                  _cell = new BagCell(0);
                  PositionUtils.setPos(_cell,"drgnBoatBuild.cellPos");
                  addChild(_cell);
                  _cell.scaleX = 1.3;
                  _cell.scaleY = 1.3;
                  _countTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.countTxt");
                  addChild(_countTxt);
                  _btn = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.thirdBuildBtn");
                  addChild(_btn);
                  _loc4_ = ServerConfigManager.instance.getDragonBoatBuildStage(2);
                  _loc3_ = _loc4_[0].split(",");
                  _loc1_ = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(int(_loc3_[0]));
                  _countTxt.text = _loc1_ + "/" + _loc3_[1];
                  _descriptionTxt.text = LanguageMgr.GetTranslation("drgnBoatBuild.description2",_loc3_[1]);
                  _loc5_ = new InventoryItemInfo();
                  _loc5_.TemplateID = _loc3_[0];
                  _loc5_ = ItemManager.fill(_loc5_);
                  _loc5_.BindType = 4;
                  _cell.info = _loc5_;
                  _cell.setCountNotVisible();
                  break;
               case 3:
                  _descriptionTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.descriptionTxt");
                  addChild(_descriptionTxt);
                  PositionUtils.setPos(_descriptionTxt,"drgnBoatBuild.descriptionTxtPos");
                  _itemBg = ComponentFactory.Instance.creat("drgnBoatBuild.itemBg");
                  addChild(_itemBg);
                  _cell = new BagCell(0);
                  PositionUtils.setPos(_cell,"drgnBoatBuild.cellPos");
                  addChild(_cell);
                  _cell.scaleX = 1.3;
                  _cell.scaleY = 1.3;
                  _countTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.countTxt");
                  addChild(_countTxt);
                  _btn = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.finalBuildBtn");
                  addChild(_btn);
                  _loc4_ = ServerConfigManager.instance.getDragonBoatBuildStage(3);
                  _loc3_ = _loc4_[0].split(",");
                  _loc1_ = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(int(_loc3_[0]));
                  _countTxt.text = _loc1_ + "/" + _loc3_[1];
                  _descriptionTxt.text = LanguageMgr.GetTranslation("drgnBoatBuild.description2",_loc3_[1]);
                  _loc5_ = new InventoryItemInfo();
                  _loc5_.TemplateID = _loc3_[0];
                  _loc5_ = ItemManager.fill(_loc5_);
                  _loc5_.BindType = 4;
                  _cell.info = _loc5_;
                  _cell.setCountNotVisible();
                  break;
               case 4:
                  _complete = ComponentFactory.Instance.creat("drgnBoatBuild.buildComplete");
                  addChild(_complete);
            }
         }
         initEvents();
      }
      
      private function initEvents() : void
      {
         if(_btn)
         {
            _btn.addEventListener("click",__btnClick);
         }
         if(_backBtn)
         {
            _backBtn.addEventListener("click",__backBtnClick);
         }
         DrgnBoatBuildManager.instance.addEventListener("updateView",__update);
      }
      
      protected function __backBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.updateDrgnBoatBuildInfo();
      }
      
      protected function __btnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_isSelf)
         {
            switch(int(_stage))
            {
               case 0:
               case 1:
               case 2:
               case 3:
                  SocketManager.Instance.out.commitDrgnBoatMaterial(_stage);
            }
         }
         else
         {
            SocketManager.Instance.out.helpToBuildDrgnBoat(_userId);
         }
      }
      
      protected function __update(param1:DrgnBoatBuildEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:DrgnBoatBuildCellInfo = param1.info as DrgnBoatBuildCellInfo;
         _progress.setData(_loc3_.progress,_loc3_.stage,1000);
         _userId = _loc3_.id;
         _isSelf = _userId == PlayerManager.Instance.Self.ID;
         _stage = _loc3_.stage;
         setView();
         ObjectUtils.disposeObject(_tipTouchArea);
         _tipTouchArea = null;
         if(!_isSelf)
         {
            if(_loc3_.playerinfo)
            {
               _titleTxt.text = _loc3_.playerinfo.NickName;
            }
         }
         else
         {
            _loc2_ = 0;
            switch(int(_loc3_.stage) - 1)
            {
               case 0:
                  _loc2_ = 330;
                  break;
               case 1:
                  _loc2_ = 660;
                  break;
               case 2:
                  _loc2_ = 990;
            }
            if(_loc3_.progress < _loc2_)
            {
               _btn.enable = false;
               createTipArea();
            }
         }
      }
      
      private function createTipArea() : void
      {
         _tipTouchArea = new Component();
         _tipTouchArea.graphics.beginFill(0,0);
         _tipTouchArea.graphics.drawRect(0,0,_btn.width,_btn.height);
         _tipTouchArea.graphics.endFill();
         _tipTouchArea.x = _btn.x;
         _tipTouchArea.y = _btn.y;
         addChild(_tipTouchArea);
         _tipTouchArea.tipStyle = "ddt.view.tips.OneLineTip";
         _tipTouchArea.tipDirctions = "5";
         _tipTouchArea.tipData = LanguageMgr.GetTranslation("drgnBoatBuild.tipData");
      }
      
      private function removeEvents() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",__btnClick);
         }
         if(_backBtn)
         {
            _backBtn.removeEventListener("click",__backBtnClick);
         }
         DrgnBoatBuildManager.instance.removeEventListener("updateView",__update);
      }
      
      private function clear() : void
      {
         ObjectUtils.disposeObject(_descriptionTxt);
         _descriptionTxt = null;
         ObjectUtils.disposeObject(_ownImg);
         _ownImg = null;
         ObjectUtils.disposeObject(_ownedBeard);
         _ownedBeard = null;
         ObjectUtils.disposeObject(_ownedWood);
         _ownedWood = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_complete);
         _complete = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_backBtn);
         _backBtn = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
      }
      
      public function dispose() : void
      {
         removeEvents();
         clear();
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_titleBmp);
         _titleBmp = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_staticBuilding);
         _staticBuilding = null;
         ObjectUtils.disposeObject(_tipTouchArea);
         _tipTouchArea = null;
      }
   }
}

package baglocked
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class BagLockPSWNeededSelecterFrame extends Frame implements Disposeable
   {
       
      
      private var _detailText:MovieClip;
      
      private var _selecterScrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _submitBtn:TextButton;
      
      private var _needPSWCellList:Vector.<BagLockPSWNeededSelecterListCell>;
      
      private var _bg:Scale9CornerImage;
      
      private var _btnBG:ScaleBitmapImage;
      
      public function BagLockPSWNeededSelecterFrame()
      {
         super();
         init();
      }
      
      override protected function init() : void
      {
         super.init();
         this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.BagLockedSettingFrame.titleText");
         _bg = ComponentFactory.Instance.creat("cardSystem.help.bgHelp");
         _bg.height = 382;
         PositionUtils.setPos(_bg,"bagLocked.bagLockBGPos");
         addToContent(_bg);
         _btnBG = ComponentFactory.Instance.creat("asset.core.btmBimap");
         _btnBG.width = 370;
         _btnBG.height = 42;
         PositionUtils.setPos(_btnBG,"bagLocked.bagLockBtnBGPos");
         addToContent(_btnBG);
         _detailText = ComponentFactory.Instance.creat("baglocked.settingDetail");
         PositionUtils.setPos(_detailText,"bagLocked.bagLockDetailPos");
         addToContent(_detailText);
         _selecterScrollPanel = ComponentFactory.Instance.creatComponentByStylename("ddtbaglock.selectScrollPanel");
         addToContent(_selecterScrollPanel);
         _vBox = new VBox();
         _vBox.spacing = 10;
         initList();
         var i:int = 0;
         for(i = 0; i < _needPSWCellList.length; )
         {
            _vBox.addChild(_needPSWCellList[i]);
            i++;
         }
         _vBox.arrange();
         _selecterScrollPanel.setView(_vBox);
         _submitBtn = ComponentFactory.Instance.creat("core.simplebt");
         _submitBtn.text = "O K";
         PositionUtils.setPos(_submitBtn,"bagLocked.bagLockBtnPos");
         _submitBtn.addEventListener("click",onSubmit);
         addToContent(_submitBtn);
      }
      
      public function initList() : void
      {
         var i:int = 0;
         var list:Array = PlayerManager.Instance.bagLockStateList;
         _needPSWCellList = new Vector.<BagLockPSWNeededSelecterListCell>();
         var len:int = 4;
         var listLen:int = list.length;
         for(i = 0; i < len; )
         {
            _needPSWCellList[i] = new BagLockPSWNeededSelecterListCell(i,list[listLen - i - 1],"tank.view.baglocked.type" + i.toString(),true);
            i++;
         }
      }
      
      public function refresh() : void
      {
         var i:int = 0;
         var list:Array = PlayerManager.Instance.bagLockStateList;
         var len:int = 4;
         var listLen:int = list.length;
         for(i = 0; i < len; )
         {
            _needPSWCellList[i].selected = list[listLen - i - 1];
            i++;
         }
      }
      
      protected function onSubmit(me:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var selectStateArr:Array = [];
         var len:int = _needPSWCellList.length;
         for(i = 0; i < len; )
         {
            selectStateArr[i] = _needPSWCellList[len - i - 1].selected;
            i++;
         }
         PlayerManager.Instance.submitBagLockPSWNeededList(selectStateArr);
         return;
         §§push(parent && parent.removeChild(this));
      }
      
      override public function dispose() : void
      {
         var len:int = 0;
         var i:int = 0;
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_btnBG != null)
         {
            ObjectUtils.disposeObject(_btnBG);
            _btnBG = null;
         }
         if(_detailText != null)
         {
            ObjectUtils.disposeObject(_detailText);
            _detailText = null;
         }
         if(_selecterScrollPanel != null)
         {
            ObjectUtils.disposeObject(_selecterScrollPanel);
            _selecterScrollPanel = null;
         }
         if(_needPSWCellList != null)
         {
            len = _needPSWCellList.length;
            for(i = 0; i < len; )
            {
               ObjectUtils.disposeObject(_needPSWCellList[i]);
               _needPSWCellList[i] = null;
               i++;
            }
            _needPSWCellList.length = 0;
            _needPSWCellList = null;
         }
         if(_vBox != null)
         {
            ObjectUtils.disposeObject(_vBox);
            _vBox = null;
         }
         if(_submitBtn != null)
         {
            ObjectUtils.disposeObject(_submitBtn);
            _submitBtn = null;
         }
         super.dispose();
      }
   }
}

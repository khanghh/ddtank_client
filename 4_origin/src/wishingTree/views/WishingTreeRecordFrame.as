package wishingTree.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import road7th.comm.PackageIn;
   
   public class WishingTreeRecordFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _desc:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _txtArr:Array;
      
      public function WishingTreeRecordFrame()
      {
         super();
         initView();
         addEvents();
         SocketManager.Instance.out.wishingTreeGetRecord();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("wishingTree.recordBg");
         addToContent(_bg);
         _desc = ComponentFactory.Instance.creatComponentByStylename("wishingTree.recordDesc");
         addToContent(_desc);
         _desc.text = "只显示最近20条许愿记录";
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("wishingTree.scrollPanel");
         addToContent(_scrollPanel);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("wishingTree.recordVBox");
         _scrollPanel.setView(_vBox);
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__responseHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(299,5),__getRecord);
      }
      
      protected function __getRecord(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:int = _loc5_.readInt();
         _txtArr = [];
         _loc8_ = 0;
         while(_loc8_ <= _loc2_ - 1)
         {
            _loc6_ = _loc5_.readDate();
            _loc7_ = _loc5_.readInt();
            _loc3_ = ItemManager.Instance.getTemplateById(_loc7_).Name;
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("wishingTree.recordTxt");
            _loc4_.text = LanguageMgr.GetTranslation("wishingTree.record",_loc6_.fullYear,_loc6_.month + 1,_loc6_.date,_loc6_.hours,_loc6_.minutes,_loc3_);
            _vBox.addChild(_loc4_);
            _txtArr.push(_loc4_);
            _loc8_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      protected function __responseHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(299,5),__getRecord);
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvents();
         _loc1_ = 0;
         while(_loc1_ <= _txtArr.length - 1)
         {
            ObjectUtils.disposeObject(_txtArr[_loc1_]);
            _txtArr[_loc1_] = null;
            _loc1_++;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_desc);
         _desc = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}

package farm.viewx.poultry
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import farm.FarmModelController;
   import farm.modelx.FarmPoultryInfo;
   import flash.utils.Dictionary;
   
   public class CallPoultryView extends BaseAlerFrame
   {
       
      
      private var _titleBg:ScaleBitmapImage;
      
      private var _btnBg:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _infoText:FilterFrameText;
      
      private var _poultryBox:ComboBox;
      
      public function CallPoultryView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:AlertInfo = new AlertInfo("",LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _loc1_.moveEnable = false;
         _loc1_.autoDispose = false;
         info = _loc1_;
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("farm.friendListTitleBg");
         PositionUtils.setPos(_titleBg,"asset.farm.poultry.titlePos");
         addToContent(_titleBg);
         _btnBg = ComponentFactory.Instance.creatComponentByStylename("farm.callPoultry.alertBg");
         addToContent(_btnBg);
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("farm.text.farmShopPayPnlTitle");
         _titleTxt.text = LanguageMgr.GetTranslation("farm.tree.callPoultry.titleText");
         PositionUtils.setPos(_titleTxt,"asset.farm.poultry.titleTxtPos");
         addToContent(_titleTxt);
         _infoText = ComponentFactory.Instance.creatComponentByStylename("farm.text.farmShopPayPnlTitle");
         _infoText.text = LanguageMgr.GetTranslation("farm.tree.callPoultry.infoText");
         PositionUtils.setPos(_infoText,"asset.farm.poultry.infoTextPos");
         addToContent(_infoText);
         _poultryBox = ComponentFactory.Instance.creatComponentByStylename("farm.poultry.callView.poultryMenu");
         addToContent(_poultryBox);
         addPoultryName();
      }
      
      private function addPoultryName() : void
      {
         var _loc2_:VectorListModel = _poultryBox.listPanel.vectorListModel;
         _loc2_.clear();
         var _loc1_:int = FarmModelController.instance.model.FarmTreeLevel;
         var _loc4_:Dictionary = FarmModelController.instance.model.farmPoultryInfo;
         if(_loc1_ > 0)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _loc4_;
            for each(var _loc3_ in _loc4_)
            {
               if(_loc3_.Level % 10 == 1 && _loc3_.Level <= _loc1_)
               {
                  _loc2_.append(_loc3_.MonsterName);
               }
            }
         }
         else
         {
            _loc2_.append(_loc4_[_loc1_].MonsterName);
         }
         _poultryBox.textField.text = _loc2_.last();
         _poultryBox.currentSelectedIndex = _loc2_.size() - 1;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__closeFarmHelper);
         _poultryBox.listPanel.list.addEventListener("listItemClick",__onListClick);
      }
      
      protected function __onListClick(param1:ListItemEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __closeFarmHelper(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(!(int(param1.responseCode) - 3))
         {
            SocketManager.Instance.out.callFarmPoultry(_poultryBox.currentSelectedIndex * 10 + 1);
         }
         dispose();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__closeFarmHelper);
         _poultryBox.listPanel.list.removeEventListener("listItemClick",__onListClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_titleBg)
         {
            _titleBg.dispose();
            _titleBg = null;
         }
         if(_btnBg)
         {
            _btnBg.dispose();
            _btnBg = null;
         }
         if(_titleTxt)
         {
            _titleTxt.dispose();
            _titleTxt = null;
         }
         if(_infoText)
         {
            _infoText.dispose();
            _infoText = null;
         }
         if(_poultryBox)
         {
            _poultryBox.dispose();
            _poultryBox = null;
         }
         super.dispose();
      }
   }
}

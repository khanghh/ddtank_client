package ddt.view.bossbox
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class VipInfoTipBox extends Frame
   {
       
      
      private var _goodsList:Array;
      
      private var _list:VipInfoTipList;
      
      private var _button:BaseButton;
      
      private var _goodsBG:ScaleBitmapImage;
      
      private var _titleBG:Image;
      
      private var _txtGetAwardsByLV:FilterFrameText;
      
      private var _selectCellInfo:ItemTemplateInfo;
      
      public function VipInfoTipBox()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get selectCellInfo() : ItemTemplateInfo
      {
         return _selectCellInfo;
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.timeBox.awardsInfo");
         _goodsBG = ComponentFactory.Instance.creat("bossbox.scale9GoodsImageIII");
         addToContent(_goodsBG);
         _titleBG = ComponentFactory.Instance.creat("bossbox.VipBoxTipBg");
         addToContent(_titleBG);
         _txtGetAwardsByLV = ComponentFactory.Instance.creat("Vip.GetAwardsByLV");
         addToContent(_txtGetAwardsByLV);
         _txtGetAwardsByLV.text = LanguageMgr.GetTranslation("ddt.vip.vipView.getAwardsByLVText");
         _button = ComponentFactory.Instance.creat("Vip.GetAwardsByLVBtn");
         addToContent(_button);
         if(!PlayerManager.Instance.Self.IsVIP)
         {
            _button.enable = false;
         }
      }
      
      public function set vipAwardGoodsList(templateIds:Array) : void
      {
         _goodsList = templateIds;
         _list = ComponentFactory.Instance.creatCustomObject("bossbox.VipInfoTipList");
         _list.showForVipAward(_goodsList);
         addChild(_list);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _button.addEventListener("click",_click);
      }
      
      private function _click(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _selectCellInfo = _list.currentCell.info;
         dispatchEvent(new FrameEvent(2));
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__frameEventHandler);
         if(_button)
         {
            _button.removeEventListener("click",_click);
            ObjectUtils.disposeObject(_button);
            _button = null;
         }
         ObjectUtils.disposeObject(_titleBG);
         _titleBG = null;
         if(_txtGetAwardsByLV)
         {
            ObjectUtils.disposeObject(_txtGetAwardsByLV);
            _txtGetAwardsByLV = null;
         }
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

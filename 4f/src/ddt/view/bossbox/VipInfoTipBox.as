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
      
      public function VipInfoTipBox(){super();}
      
      public function get selectCellInfo() : ItemTemplateInfo{return null;}
      
      private function initView() : void{}
      
      public function set vipAwardGoodsList(param1:Array) : void{}
      
      private function initEvent() : void{}
      
      private function _click(param1:MouseEvent) : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}

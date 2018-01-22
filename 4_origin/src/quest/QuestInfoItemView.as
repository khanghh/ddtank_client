package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class QuestInfoItemView extends Sprite implements Disposeable
   {
       
      
      protected var _titleBg:Bitmap;
      
      protected var _titleImg:ScaleFrameImage;
      
      protected var _content:Sprite;
      
      protected var _panel:ScrollPanel;
      
      protected var _info:QuestInfo;
      
      public function QuestInfoItemView()
      {
         super();
         initView();
      }
      
      override public function get height() : Number
      {
         return _panel.y + Math.min(_content.height,_panel.height);
      }
      
      protected function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.quest.questinfoItemTitle");
         addChild(_titleBg);
         _content = new Sprite();
         _panel = ComponentFactory.Instance.creatComponentByStylename("core.quest.QuestInfoItem.scrollPanel");
         _panel.setView(_content);
         addChild(_panel);
      }
      
      public function set info(param1:QuestInfo) : void
      {
         _info = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeAllChildren(_content);
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_titleImg)
         {
            _titleImg.dispose();
            _titleImg = null;
         }
      }
   }
}

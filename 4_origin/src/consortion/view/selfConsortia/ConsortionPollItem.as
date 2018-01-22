package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortionPollInfo;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortionPollItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _name:FilterFrameText;
      
      private var _count:FilterFrameText;
      
      private var _info:ConsortionPollInfo;
      
      private var _selected:Boolean;
      
      private var _index:int;
      
      public function ConsortionPollItem(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _selected = false;
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.pollItem.bg");
         _index % 2 == 0?_bg.setFrame(1):_bg.setFrame(2);
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.pollItem.selected");
         _name = ComponentFactory.Instance.creatComponentByStylename("consortion.pollItem.name");
         _count = ComponentFactory.Instance.creatComponentByStylename("consortion.pollItem.count");
         addChild(_bg);
         addChild(_selectedBtn);
         _selectedBtn.addChild(_name);
         addChild(_count);
      }
      
      override public function get height() : Number
      {
         if(_bg == null)
         {
            return 0;
         }
         return _bg.y + _bg.displayHeight;
      }
      
      public function set info(param1:ConsortionPollInfo) : void
      {
         _info = param1;
         _name.text = _info.pollName;
         _count.text = String(_info.pollCount);
      }
      
      public function get info() : ConsortionPollInfo
      {
         return _info;
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function __selectHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         selected = _selected == true?false:true;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!selected)
         {
            _bg.visible = true;
            _bg.setFrame(1);
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(!selected)
         {
            _bg.visible = false;
            _bg.setFrame(1);
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _selectedBtn.selected = param1;
      }
      
      public function get selected() : Boolean
      {
         return _selectedBtn.selected;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _selectedBtn = null;
         _name = null;
         _count = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

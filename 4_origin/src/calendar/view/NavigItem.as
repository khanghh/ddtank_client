package calendar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class NavigItem extends Sprite implements Disposeable
   {
       
      
      private var _back:DisplayObject;
      
      private var _textField:FilterFrameText;
      
      private var _count:int;
      
      private var _selected:Boolean = false;
      
      private var _received:Boolean = false;
      
      public function NavigItem(count:int)
      {
         super();
         _count = count;
         mouseChildren = false;
         buttonMode = true;
         configUI();
      }
      
      private function configUI() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.NavigBack");
         scaleY = 0.9;
         _back.scaleX = 0.9;
         DisplayUtils.setFrame(_back,1);
         addChildAt(_back,0);
         _textField = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.AwardCountField");
         _textField.text = _count.toString() + LanguageMgr.GetTranslation("tank.calendar.award.NagivCount");
         addChild(_textField);
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected == value)
         {
            return;
         }
         _selected = value;
         if(_selected)
         {
            _textField.setFrame(2);
            DisplayUtils.setFrame(_back,2);
         }
         else if(!_received)
         {
            _textField.setFrame(1);
            DisplayUtils.setFrame(_back,1);
         }
      }
      
      public function get received() : Boolean
      {
         return _received;
      }
      
      public function set received(value:Boolean) : void
      {
         if(_received == value)
         {
            return;
         }
         _received = value;
         mouseEnabled = !_received;
         if(_received)
         {
            DisplayUtils.setFrame(_back,3);
         }
         else if(_selected)
         {
            DisplayUtils.setFrame(_back,2);
         }
         else
         {
            DisplayUtils.setFrame(_back,1);
         }
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_textField);
         _textField = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

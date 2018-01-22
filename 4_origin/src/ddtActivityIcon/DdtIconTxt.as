package ddtActivityIcon
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.view.ConsortiaBattleEntryBtn;
   import flash.display.Sprite;
   import worldboss.view.WorldBossIcon;
   
   public class DdtIconTxt extends Sprite
   {
       
      
      private var _txt:FilterFrameText;
      
      private var _isOver:Boolean;
      
      private var _sp:Sprite;
      
      private var _isOpen:Boolean;
      
      public function DdtIconTxt()
      {
         super();
         initView();
      }
      
      public function addActIcon(param1:Sprite) : void
      {
         _sp = param1;
         if(param1 is WorldBossIcon)
         {
            param1.y = 216;
            param1.x = 33;
            addChild(param1);
            return;
         }
         if(param1 is ConsortiaBattleEntryBtn)
         {
            param1.x = 34;
            param1.y = 167;
            addChild(param1);
            return;
         }
         addChild(param1);
         param1.y = _txt.y - param1.height;
         param1.x = _txt.width / 2 - param1.width / 2 + _txt.x;
         isOver = true;
      }
      
      public function resetPos() : void
      {
         var _loc1_:int = 0;
         _sp.y = _loc1_;
         _sp.x = _loc1_;
         _txt.x = _sp.x + _sp.width / 2 - _txt.width / 2;
         _txt.y = _sp.y + _sp.height;
      }
      
      public function set isOver(param1:Boolean) : void
      {
         _isOver = param1;
      }
      
      public function get isOver() : Boolean
      {
         return _isOver;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("activity.txt");
         addChild(_txt);
      }
      
      public function setTxt(param1:String) : void
      {
         _txt.text = param1;
      }
      
      public function resetTxt() : void
      {
         if(_txt)
         {
            _txt.text = "";
         }
         _isOver = false;
         _isOpen = false;
         DdtActivityIconManager.Instance.isOneOpen = false;
         ObjectUtils.disposeObject(_sp);
         _sp = null;
      }
      
      public function dispose() : void
      {
         _isOver = false;
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         _sp = null;
         _txt = null;
      }
      
      public function get sp() : Sprite
      {
         return _sp;
      }
   }
}

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
      
      public function addActIcon(sp:Sprite) : void
      {
         _sp = sp;
         if(sp is WorldBossIcon)
         {
            sp.y = 216;
            sp.x = 33;
            addChild(sp);
            return;
         }
         if(sp is ConsortiaBattleEntryBtn)
         {
            sp.x = 34;
            sp.y = 167;
            addChild(sp);
            return;
         }
         addChild(sp);
         sp.y = _txt.y - sp.height;
         sp.x = _txt.width / 2 - sp.width / 2 + _txt.x;
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
      
      public function set isOver(bool:Boolean) : void
      {
         _isOver = bool;
      }
      
      public function get isOver() : Boolean
      {
         return _isOver;
      }
      
      public function set isOpen(bool:Boolean) : void
      {
         _isOpen = bool;
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
      
      public function setTxt(str:String) : void
      {
         _txt.text = str;
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

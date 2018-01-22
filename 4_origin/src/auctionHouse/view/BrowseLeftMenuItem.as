package auctionHouse.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.CateCoryInfo;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BrowseLeftMenuItem extends Sprite implements Disposeable, IMenuItem
   {
       
      
      private var accect:BrowserLeftStripAsset;
      
      private var _info:CateCoryInfo;
      
      private var _isOpen:Boolean = false;
      
      private var _hasIcon:Boolean;
      
      private var _hideIcon:Boolean;
      
      public function BrowseLeftMenuItem(param1:BrowserLeftStripAsset, param2:CateCoryInfo, param3:Boolean = false)
      {
         super();
         accect = param1;
         _info = param2;
         _hideIcon = param3;
         buttonMode = true;
         addChild(accect);
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         accect.addEventListener("click",btnClickHandler);
         addRollEvent();
         if(accect.icon)
         {
            _hasIcon = true;
            if(_hideIcon)
            {
               accect.icon.visible = false;
            }
            accect.icon.setFrame(1);
         }
      }
      
      public function dispose() : void
      {
         if(accect)
         {
            removeRollEvent();
            ObjectUtils.disposeObject(accect);
         }
         accect = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function removeRollEvent() : void
      {
         accect.removeEventListener("click",btnClickHandler);
         accect.removeEventListener("rollOver",btnClickHandler);
         accect.removeEventListener("rollOut",btnClickHandler);
      }
      
      private function addRollEvent() : void
      {
         accect.addEventListener("rollOver",btnClickHandler);
         accect.addEventListener("rollOut",btnClickHandler);
      }
      
      private function initView() : void
      {
         accect.type_txt.text = _info.Name;
         accect.type_text = _info.Name;
      }
      
      public function get info() : Object
      {
         return _info;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
         if(_isOpen && _hasIcon)
         {
            accect.icon.setFrame(2);
            accect.setFrameOnImage(1);
         }
         else if(!_isOpen && _hasIcon)
         {
            accect.icon.setFrame(1);
            accect.setFrameOnImage(2);
         }
         else
         {
            accect.icon.setFrame(1);
            accect.setFrameOnImage(2);
         }
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(param1)
         {
            accect.bg.setFrame(1);
            accect.setFrameOnImage(2);
            accect.selectState = false;
            addRollEvent();
         }
         else
         {
            accect.bg.setFrame(2);
            accect.setFrameOnImage(1);
            accect.selectState = true;
            removeRollEvent();
         }
      }
      
      private function btnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.type;
         if("click" !== _loc2_)
         {
            if("rollOver" !== _loc2_)
            {
               if("rollOut" === _loc2_)
               {
                  accect.bg.setFrame(1);
               }
            }
            else
            {
               accect.bg.setFrame(1);
            }
         }
         else
         {
            accect.bg.setFrame(2);
            accect.setFrameOnImage(1);
            accect.selectState = true;
         }
      }
   }
}

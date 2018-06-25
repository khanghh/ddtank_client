package starlingui.core.components
{
   import starling.display.DisplayObject;
   import starlingui.editor.core.IBox;
   
   public class Box extends Component implements IBox
   {
       
      
      public function Box()
      {
         super();
      }
      
      override protected function preinitialize() : void
      {
         touchable = false;
      }
      
      public function addElement(element:DisplayObject, x:Number = 0, y:Number = 0) : void
      {
         element.x = x;
         element.y = y;
         addChild(element);
      }
      
      public function addElementAt(element:DisplayObject, index:int, x:Number = 0, y:Number = 0) : void
      {
         element.x = x;
         element.y = y;
         addChildAt(element,index);
      }
      
      public function addElements(elements:Array) : void
      {
         var i:int = 0;
         var n:int = 0;
         var item:* = null;
         for(i = 0,n = elements.length; i < n; )
         {
            item = elements[i];
            addChild(item);
            i++;
         }
      }
      
      public function removeElement(element:DisplayObject, dispose:Boolean = false) : void
      {
         if(element && contains(element))
         {
            removeChild(element,dispose);
         }
      }
      
      public function removeAllChild(except:DisplayObject = null, dispose:Boolean = false) : void
      {
         var i:int = 0;
         for(i = numChildren - 1; i > -1; )
         {
            if(except != getChildAt(i))
            {
               removeChildAt(i,dispose);
            }
            i--;
         }
      }
      
      public function insertAbove(element:DisplayObject, compare:DisplayObject) : void
      {
         removeElement(element);
         var index:int = getChildIndex(compare);
         addChildAt(element,Math.min(index + 1,numChildren));
      }
      
      public function insertBelow(element:DisplayObject, compare:DisplayObject) : void
      {
         removeElement(element);
         var index:int = getChildIndex(compare);
         addChildAt(element,Math.max(index,0));
      }
      
      override public function set dataSource(value:Object) : void
      {
         var comp:* = null;
         _dataSource = value;
         var _loc5_:int = 0;
         var _loc4_:* = value;
         for(var name in value)
         {
            comp = getChildByName(name) as Component;
            if(comp)
            {
               comp.dataSource = value[name];
            }
            else if(hasOwnProperty(name))
            {
               this[name] = value[name];
            }
         }
      }
   }
}

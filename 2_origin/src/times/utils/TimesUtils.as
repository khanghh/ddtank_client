package times.utils
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import times.TimesController;
   import times.data.TimesEvent;
   import times.data.TimesPicInfo;
   
   public class TimesUtils
   {
      
      private static var _reg:RegExp = /\{(\d+)\}/;
       
      
      public function TimesUtils()
      {
         super();
      }
      
      public static function setPos(obj:*, posStyle:String) : void
      {
         var pos:Point = ComponentFactory.Instance.creatCustomObject(posStyle);
         obj.x = pos.x;
         obj.y = pos.y;
      }
      
      public static function getWords(stylename:String, ... args) : String
      {
         var id:int = 0;
         var xml:XML = ComponentFactory.Instance.getCustomStyle(stylename);
         var str:String = xml.@value;
         var obj:Object = _reg.exec(str);
         while(obj && args.length > 0)
         {
            id = obj[1];
            if(id >= 0 && id < args.length)
            {
               str = str.replace(_reg,args[id]);
            }
            else
            {
               str = str.replace(_reg,"{}");
            }
            obj = _reg.exec(str);
         }
         return str;
      }
      
      public static function createCell(loader:Loader, info:TimesPicInfo) : Array
      {
         var arr:* = null;
         var movie:* = null;
         var itemMc:* = null;
         var len:int = 0;
         var name:* = null;
         var factory:* = undefined;
         var i:int = 0;
         var cell:* = undefined;
         var shape:* = null;
         var shape1:* = null;
         if(loader && loader.content as MovieClip)
         {
            movie = loader.content as MovieClip;
            len = movie.numChildren;
            factory = getDefinitionByName("bagAndInfo.cell.CellFactory");
            for(i = 0; i < len; )
            {
               itemMc = movie.getChildAt(i) as MovieClip;
               if(itemMc != null)
               {
                  name = itemMc.name;
                  if(name.substr(0,4) == "good")
                  {
                     if(!arr)
                     {
                        arr = [];
                     }
                     shape = new Shape();
                     shape.graphics.lineStyle(1,16777215,0);
                     shape.graphics.drawRect(0,0,itemMc.width,itemMc.height);
                     cell = factory.instance.createWeeklyItemCell(shape,name.substr(5));
                     cell.x = itemMc.x;
                     cell.y = itemMc.y;
                     cell.alpha = 0;
                     arr.push(cell);
                  }
                  else if(name.substr(0,8) == "purchase")
                  {
                     TimesController.Instance.dispatchEvent(new TimesEvent("pushTipItems",info,[itemMc]));
                     if(!arr)
                     {
                        arr = [];
                     }
                     shape1 = new Shape();
                     shape1.graphics.lineStyle(1,16777215,0);
                     shape1.graphics.drawRect(0,0,itemMc.width,itemMc.height);
                     cell = factory.instance.createWeeklyItemCell(shape1,name.substr(9));
                     cell.name = name.substr(9);
                     cell.x = itemMc.x;
                     cell.y = itemMc.y;
                     cell.alpha = 0;
                     cell.addEventListener("click",quickBuy);
                     cell.buttonMode = true;
                     arr.push(cell);
                  }
               }
               i++;
            }
         }
         var key:int = 0;
         if(movie && arr && arr.length > 0)
         {
            while(movie.numChildren == len && len > key)
            {
               if(movie.getChildAt(key).name.substr(0,4) == "good")
               {
                  movie.removeChildAt(key);
                  len--;
               }
               else
               {
                  key++;
               }
            }
         }
         if(arr)
         {
            TimesController.Instance.dispatchEvent(new TimesEvent("pushTipCells",info,arr));
         }
         return arr;
      }
      
      private static function quickBuy(e:MouseEvent) : void
      {
         var info:TimesPicInfo = new TimesPicInfo();
         info.templateID = int(e.currentTarget.name);
         TimesController.Instance.dispatchEvent(new TimesEvent("purchase",info));
      }
   }
}

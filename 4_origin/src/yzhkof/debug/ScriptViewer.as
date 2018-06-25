package yzhkof.debug
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   import yzhkof.ui.DragPanel;
   import yzhkof.ui.TextPanel;
   import yzhkof.ui.TileContainer;
   import yzhkof.ui.event.ComponentEvent;
   import yzhkof.util.StringUtil;
   
   public class ScriptViewer extends DragPanel
   {
       
      
      private var textField:TextField;
      
      private var btn_container:TileContainer;
      
      private var run_btn:TextPanel;
      
      private var target_btn:TextPanel;
      
      private var save_btn:TextPanel;
      
      private var load_btn:TextPanel;
      
      private var import_btn:TextPanel;
      
      private var import_text:TextField;
      
      private const textWidth:Number = 500;
      
      private const textHeight:Number = 300;
      
      private var importCount:uint = 0;
      
      public function ScriptViewer()
      {
         this.textField = new TextField();
         this.btn_container = new TileContainer();
         this.run_btn = new TextPanel(16776960);
         this.target_btn = new TextPanel(16776960);
         this.save_btn = new TextPanel(16776960);
         this.load_btn = new TextPanel(16776960);
         this.import_btn = new TextPanel(16776960);
         this.import_text = new TextField();
         super();
         this.init();
         ScriptRuner.init();
      }
      
      public function setTarget(target:Object) : void
      {
         ScriptRuner.target = target;
         this.target_btn.text = getQualifiedClassName(target);
      }
      
      private function init() : void
      {
         _content.addChild(this.textField);
         _content.addChild(this.btn_container);
         this.btn_container.width = 1000;
         this.btn_container.height = 10;
         this.btn_container.appendItem(this.run_btn);
         this.btn_container.appendItem(this.target_btn);
         this.btn_container.appendItem(this.save_btn);
         this.btn_container.appendItem(this.load_btn);
         this.btn_container.appendItem(this.import_btn);
         this.btn_container.appendItem(this.import_text);
         this.run_btn.text = "run";
         this.import_btn.text = "import";
         this.target_btn.text = getQualifiedClassName(ScriptRuner.target);
         this.save_btn.text = "save";
         this.load_btn.text = "load";
         this.import_text.border = true;
         this.import_text.type = TextFieldType.INPUT;
         this.import_text.height = 20;
         this.textField.y = 30;
         this.textField.type = TextFieldType.INPUT;
         this.textField.width = this.textWidth;
         this.textField.height = this.textHeight;
         this.textField.multiline = true;
         var t_format:TextFormat = this.textField.getTextFormat();
         t_format.size = 15;
         this.textField.defaultTextFormat = t_format;
         drawBackGround();
         this.run_btn.addEventListener(MouseEvent.CLICK,this.__onRunBtnClick);
         this.target_btn.addEventListener(MouseEvent.CLICK,this.__onTargetClick);
         this.import_btn.addEventListener(MouseEvent.CLICK,this.__onImportClick);
         this.save_btn.addEventListener(MouseEvent.CLICK,this.__onSaveClick);
         this.load_btn.addEventListener(MouseEvent.CLICK,this.__onLoadClick);
         this.target_btn.addEventListener(ComponentEvent.DRAW_COMPLETE,this.__btnSizeChange);
      }
      
      private function __btnSizeChange(e:Event) : void
      {
         this.btn_container.draw();
      }
      
      private function __onSaveClick(e:Event) : void
      {
         var file:FileReference = new FileReference();
         file.save(this.textField.text,"script.txt");
      }
      
      private function __onLoadClick(e:Event) : void
      {
         var file:FileReference = null;
         file = new FileReference();
         file.browse([new FileFilter("script txt","*.txt")]);
         file.addEventListener(Event.SELECT,function(e:Event):void
         {
            file.load();
         });
         file.addEventListener(Event.COMPLETE,function(e:Event):void
         {
            textField.text = String(file.data);
         });
      }
      
      private function __onImportClick(e:Event) : void
      {
         this.textField.text = StringUtil.addString(this.textField.text,"namespace n" + this.importCount + " = \"" + this.getPackageName() + "\"; use namespace n" + this.importCount + ";\n",0);
         this.importCount++;
      }
      
      private function getPackageName() : String
      {
         if(this.import_text.text)
         {
            return this.import_text.text;
         }
         return "****";
      }
      
      private function __onTargetClick(e:Event) : void
      {
         var text_content:String = this.textField.text;
         this.textField.text = StringUtil.replaceString(this.textField.text,"ScriptRuner.target",this.textField.selectionBeginIndex,this.textField.selectionEndIndex);
      }
      
      private function __onRunBtnClick(e:Event) : void
      {
         if(this.textField.text)
         {
            ScriptRuner.run(this.textField.text);
         }
      }
   }
}

import java.awt.datatransfer.*;  
import java.awt.dnd.*; 
import java.io.*;  
import java.util.*;
import java.awt.Component;

void drop_init() {  
  new DropTarget((Component)this.surface.getNative(), new DropTargetListener() {  
    public void dragEnter(DropTargetDragEvent event) {
    }  
    public void dragOver(DropTargetDragEvent event) {
    }  
    public void dropActionChanged(DropTargetDragEvent event) {
    }  
    public void dragExit(DropTargetEvent event) {
    }  
    public void drop(DropTargetDropEvent event) {  
      event.acceptDrop(DnDConstants.ACTION_COPY_OR_MOVE);  
      Transferable trans = event.getTransferable();  
      List<File> fileNameList = null;  
      if (trans.isDataFlavorSupported(DataFlavor.javaFileListFlavor)) {  
        try {  
          fileSelected((List<File>) trans.getTransferData(DataFlavor.javaFileListFlavor));
        } 
        catch (Exception e) {
        }
      }
    }
  }
  );
}

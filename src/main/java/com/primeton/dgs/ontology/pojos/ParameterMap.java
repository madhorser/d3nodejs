package com.primeton.dgs.ontology.pojos;

import java.util.HashMap;  
public class ParameterMap extends HashMap<Object, Object> {  
    private static final long serialVersionUID = 1L;  
    /* 使我们可以通过如 Name, XXX, gender, XXX 形式来组装 Map */
    public ParameterMap(Object... parameters) {  
        for (int i = 0; i < parameters.length - 1; i += 2) {  
            super.put(parameters[i], parameters[i + 1]);  
        }  
    }  
}  
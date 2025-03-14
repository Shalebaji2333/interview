package com.szl.mianshi.common;

import java.io.Serializable;
import lombok.Data;

/**
 * 删除请求
 *
 * @author szl
 * @from www.szl.icu
 */
@Data
public class DeleteRequest implements Serializable {

    /**
     * id
     */
    private Long id;

    private static final long serialVersionUID = 1L;
}